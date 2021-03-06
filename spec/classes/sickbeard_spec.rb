require 'spec_helper'
lsbdist = {:Debian => 'Ubuntu', :RedHat => 'CentOS', :Suse => 'openSUSE project' }
lcd = {:Debian => 'precise', :RedHat => 'Final', :Suse => 'Harlequin' }
confile = {:Debian => '/etc/defaults/sickbeard', :RedHat => '/etc/sysconfig/sickbeard' , :Suse => '/etc/sysconfig/sickbeard' }

describe 'sickbeard' do
  context 'supported operating systems' do
    ['Debian', 'RedHat', 'Suse'].each do |osfamily|
      describe "without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
          :lsbdistid => lsbdist[osfamily.to_sym],
          :lsbdistcodename => lcd[osfamily.to_sym],
          :os_maj_version => 6,
          :architecture => 'x68_64'
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('sickbeard') }
        it { is_expected.to contain_class('sickbeard::defaults') }
        it { is_expected.to contain_class('sickbeard::users').that_comes_before('sickbeard::repo') }
        it { is_expected.to contain_class('sickbeard::repo').that_comes_before('sickbeard::install') }
        it { is_expected.to contain_class('sickbeard::install').that_comes_before('sickbeard::sysconfig') }
        it { is_expected.to contain_class('sickbeard::sysconfig').that_comes_before('sickbeard::config') }
        it { is_expected.to contain_class('sickbeard::config') }
        it { is_expected.to contain_class('sickbeard::service').that_subscribes_to('sickbeard::config') }
        it { is_expected.to contain_class('sickbeard::service').that_subscribes_to('sickbeard::sysconfig') }
        it { is_expected.to contain_file('/var/lib/sickbeard/config.ini') }
        it { is_expected.to contain_file('/var/lib/sickbeard') }

        it { is_expected.to contain_service('sickbeard') }
        it { is_expected.to contain_package('sickbeard').with_ensure('present') }
        it { is_expected.to contain_file(confile[osfamily.to_sym]) }
        it { is_expected.to contain_file('/var/lib/sickbeard/Logs') }
        it { is_expected.to contain_file('/var/lib/sickbeard/cache') }
        it { is_expected.to contain_group('sickbeard') }
        it { is_expected.to contain_user('sickbeard') }

        if osfamily == 'Debian'
          #it { is_expected.to contain_anchor('apt::source::ppajcfp_ppa') }
          #it { is_expected.to contain_apt__source('ppajcfp_ppa') }
          #it { is_expected.to contain_class('apt::params') }
          #it { is_expected.to contain_class('apt::update') }
          #it { is_expected.to contain_exec('apt_update') }
          #it { is_expected.to contain_file('ppajcfp_ppa.list') }
          #it { is_expected.to contain_sickbeard__repo__ppa('ppa:jcfp/ppa') }
        end
        if osfamily == 'RedHat'
          it { is_expected.to contain_yumrepo('http__dl.fedoraproject.org_pub_epel_6_x68_64') }
          it { is_expected.to contain_yumrepo('http__packages.atrpms.net_dist_el6_unrar_') }
          it { is_expected.to contain_yumrepo('https__dl.dropboxusercontent.com_u_14500830_SABnzbd_RHEL-CentOS_6') }
          it { is_expected.to contain_sickbeard__repo__yum('http://dl.fedoraproject.org/pub/epel/6/x68_64') }
          it { is_expected.to contain_sickbeard__repo__yum('http://packages.atrpms.net/dist/el6/unrar/') }
          it { is_expected.to contain_sickbeard__repo__yum('https://dl.dropboxusercontent.com/u/14500830/SABnzbd/RHEL-CentOS/6') }
        end
        if osfamily == 'Suse'
          it { is_expected.to contain_sickbeard__repo__zyp('http://download.opensuse.org/repositories/Archiving/SLE_12') }
          it { is_expected.to contain_sickbeard__repo__zyp('http://download.opensuse.org/repositories/home:/waveclaw:/HTPC/SLE_12') }
          it { is_expected.to contain_zypprepo('http__download.opensuse.org_repositories_Archiving_SLE_12') }
          it { is_expected.to contain_zypprepo('http__download.opensuse.org_repositories_home_waveclaw_HTPC_SLE_12') }
        end
     end
      describe "with parameters on #{osfamily}" do
        let(:params) {{ 
  :user_name        => 'foouser',
  :group_name       => 'foogroup',
  :data_path        => '/bin/foo',
  :pidfile          => '/var/foo/pid',
  :nice             => -42,
  :options          => 'nothing',
  :webuser          => 'baruser',
  :webpass          => 'barpass',
  :apikey           => 'guestme',
  :root_path        => '/root/path',
  :tv_download_path => 'sideloads',
  :servers          => {},
  :sabnzbd          => {},
  :plex             => {},
  :newznab          => {},
  :package_name     => 'foopackage',
  :service_name     => 'barservice',
  :sysconfig_path   => '/dev/null',
  :repo_name        => 'ftp://stuffs'
        }}
        let(:facts) {{
          :osfamily => osfamily,
          :lsbdistid => lsbdist[osfamily.to_sym],
          :lsbdistcodename => lcd[osfamily.to_sym],
          :os_maj_version => 6,
          :architecture => 'x68_64'
        }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('sickbeard') }
        it { is_expected.to contain_class('sickbeard::defaults') }
        it { is_expected.to contain_class('sickbeard::users').that_comes_before('sickbeard::repo') }
        it { is_expected.to contain_class('sickbeard::repo').that_comes_before('sickbeard::install') }
        it { is_expected.to contain_class('sickbeard::install').that_comes_before('sickbeard::sysconfig') }
        it { is_expected.to contain_class('sickbeard::sysconfig').that_comes_before('sickbeard::config') }
        it { is_expected.to contain_class('sickbeard::config') }
        it { is_expected.to contain_class('sickbeard::service').that_subscribes_to('sickbeard::config') }
        it { is_expected.to contain_class('sickbeard::service').that_subscribes_to('sickbeard::sysconfig') }
        it { is_expected.to contain_file('/bin/foo/config.ini') }
        it { is_expected.to contain_file('/bin/foo') }

        it { is_expected.to contain_service('barservice') }
        it { is_expected.to contain_package('foopackage').with_ensure('present') }
        it { is_expected.to contain_file('/dev/null/sickbeard') }
        it { is_expected.to contain_file('/bin/foo/Logs') }
        it { is_expected.to contain_file('/bin/foo/cache') }
        it { is_expected.to contain_group('foogroup') }
        it { is_expected.to contain_user('foouser') }

        if osfamily == 'Debian'
          #it { is_expected.to contain_anchor('apt::source::ppajcfp_ppa') }
          #it { is_expected.to contain_apt__source('ppajcfp_ppa') }
          #it { is_expected.to contain_class('apt::params') }
          #it { is_expected.to contain_class('apt::update') }
          #it { is_expected.to contain_exec('apt_update') }
          #it { is_expected.to contain_file('ppajcfp_ppa.list') }
          #it { is_expected.to contain_sickbeard__repo__ppa('ppa:jcfp/ppa') }
        end
        if osfamily == 'RedHat'
          it { is_expected.to contain_yumrepo('ftp__stuffs') }
          it { is_expected.to contain_sickbeard__repo__yum('ftp://stuffs') }
        end
        if osfamily == 'Suse'
          it { is_expected.to contain_zypprepo('ftp__stuffs') }
          it { is_expected.to contain_sickbeard__repo__zyp('ftp://stuffs') }
        end
     end
    end
  end
  
  context 'unsupported operating system' do
    describe 'sickbeard class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('sickbeard') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
