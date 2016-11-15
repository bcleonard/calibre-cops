require "serverspec"
require "docker"
require "spec_helper"

Docker.options[:read_timeout] = 900
COPS_PORT = 80
CALIBRE_VER = "2.60.0"
DATA_DIR = "/tmp/data"

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.build_from_dir('.') 

    set :os, family: :fedora
    set :backend, :docker
    set :docker_image, @image.id

    @image.tag('repo' => 'local/calibre-cops-testing', 'tag' => 'latest', force: true)
     
  end

  it "installs the right version of fedora" do
    expect(os_version).to include("Fedora release 24")
  end

  describe package("calibre") do
    it { should be_installed.with_version('2.60.0') }
  end

  describe package("nginx") do
    it { should be_installed }
  end

  describe 'Dockerfile#config' do
    it 'should expose the cops port 80' do
      expect(@image.json['ContainerConfig']['ExposedPorts']).to include("#{COPS_PORT}/tcp")
    end
    it 'should have COPSLIBRARYNAME equals COPS' do
      expect(@image.json['ContainerConfig']['Env']).to include("COPSLIBRARYNAME=COPS")
    end
  end

  describe file('/usr/share/nginx/html/cops') do
    it { should be_directory }
  end

  describe file('/scripts/nginx.conf') do
    it { should be_mode 664 }
  end

  describe file('/scripts/list-books.sh') do
    it { should be_mode 755 }
  end

  describe file('/scripts/remove-books.sh') do
    it { should be_mode 755 }
  end

  describe file('/scripts/startup-cops.sh') do
    it { should be_mode 755 }
  end

  describe 'Dockerfile#running' do
    before (:all) do
      @container = Docker::Container.create(
       'Image' => @image.id,
       'HostConfig' => {
          'Binds' => ["#{DATA_DIR}:/data:Z"],
          'PortBindings' => { "#{COPS_PORT}/tcp" => [{ 'HostPort' => "#{COPS_PORT}" }] }
        }
      )

      @container.start('Binds' => ["#{DATA_DIR}:/data:Z"])
    end

    describe "running calibre server" do
#      describe command('ls /data') do
#        its(:stdout) { should eq 0 }
#      end
#      describe command('/usr/bin/netstat -tunl | /usr/bin/grep 8080') do
#        its(:exit_status) { should eq 0 }
#      end
      describe command('/usr/bin/ps -eaf | /usr/bin/grep nginx') do
        its(:exit_status) { should eq 0 }
      end 
    end

    after(:all) do
      @container.kill
      @container.delete(:force => true)
    end
  end
end
