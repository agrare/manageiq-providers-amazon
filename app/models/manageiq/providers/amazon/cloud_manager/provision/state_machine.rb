module ManageIQ::Providers::Amazon::CloudManager::Provision::StateMachine
  def determine_placement
    availability_zone, cloud_network, cloud_subnet = placement

    options[:dest_availability_zone] = [availability_zone.try(:id), availability_zone.try(:name)]
    options[:cloud_network]          = [cloud_network.try(:id), cloud_network.try(:name)]
    options[:cloud_subnet]           = [cloud_subnet.try(:id), cloud_subnet.try(:name)]

    signal :prepare_volumes
  end

  def customize_destination
    message = "Setting New #{destination_type} Name"
    _log.info("#{message} #{for_destination}")
    update_and_notify_parent(:message => message)

    destination.set_custom_field("Name", dest_name)
    destination.update(:name => dest_name)

    super
  end
end
