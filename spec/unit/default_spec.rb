require_relative '../spec_helper'

describe 'packages::default' do # rubocop:disable BlockLength
  context 'packages attribute is an array' do # rubocop:disable BlockLength
    context 'default action is install' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.set['packages-cookbook'] = [git]
        end.converge(described_recipe)
      end

      it 'installs git' do
        expect(chef_run).to install_package('git')
      end
    end

    context 'default action is install multiple' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.set['packages-cookbook'] = [bash, openssl]
        end.converge(described_recipe)
      end

      it 'installs bash and openssl' do
        expect(chef_run).to install_package(%w[bash openssl])
      end
    end

    context 'default action is install multiple separately' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.12') do |node|
          node.set['packages-cookbook'] = %w[bash openssl]
        end.converge(described_recipe)
      end

      it 'installs bash' do
        expect(chef_run).to install_package('bash')
      end
      it 'installs openssl' do
        expect(chef_run).to install_package('openssl')
      end
    end

    context 'default action is upgrade' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.set['packages-cookbook'] = [git]
          node.set['packages-cookbook_default_action'] = 'upgrade'
        end.converge(described_recipe)
      end

      it 'upgrades git' do
        expect(chef_run).to upgrade_package('git')
      end
    end

    context 'default action is upgrade multiple' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.set['packages-cookbook'] = [bash, openssl]
          node.set['packages-cookbook_default_action'] = 'upgrade'
        end.converge(described_recipe)
      end

      it 'upgrades bash and openssl' do
        expect(chef_run).to upgrade_package([bash, openssl])
      end
    end
  end

  context 'packages attribute is a hash' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.set['packages-cookbook'] = { 'bash' => 'install', 'openssl' => 'upgrade', 'xorg-common' => 'remove' }
      end.converge(described_recipe)
    end

    it 'installs bash' do
      expect(chef_run).to install_package('bash')
    end

    it 'upgrades openssl' do
      expect(chef_run).to upgrade_package('openssl')
    end

    it 'removes xorg-common' do
      expect(chef_run).to remove_package('xorg-common')
    end
  end
end
