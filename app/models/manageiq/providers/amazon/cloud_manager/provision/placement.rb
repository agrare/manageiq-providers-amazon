module ManageIQ::Providers::Amazon::CloudManager::Provision::Placement
  protected

  def automatic_placement
    availability_zone = super
    cloud_network = nil
    cloud_subnet = nil

    return availability_zone, cloud_network, cloud_subnet
  end

  def manual_placement
    availability_zone = super
    cloud_network = CloudNetwork.find_by(:id => get_option(:cloud_network))
    cloud_subnet  = CloudSubnet.find_by(:id => get_option(:cloud_subnet))

    return availability_zone, cloud_network, cloud_subnet
  end
end
