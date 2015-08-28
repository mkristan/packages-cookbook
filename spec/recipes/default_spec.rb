require_relative '../spec_helper'

describe 'packages::default' do
  context 'packages attribute is an array' do
    context 'default action is install' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new do |node|
          node.set['packages'] = %w(bash openssl)
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
        ChefSpec::SoloRunner.new do |node|
          node.set['packages'] = %w(bash openssl)
          node.set['packages_default_action'] = 'upgrade'
        end.converge(described_recipe)
      end

      it 'installs bash' do
        expect(chef_run).to upgrade_package('bash')
      end

      it 'installs openssl' do
        expect(chef_run).to upgrade_package('openssl')
      end
    end
  end

  context 'packages attribute is a hash' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['packages'] = { 'bash' => 'install', 'openssl' => 'upgrade', 'xorg-common' => 'remove' }
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
