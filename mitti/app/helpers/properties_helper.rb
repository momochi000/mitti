module PropertiesHelper
  def properties_options
    # TODO: as the list of properties grows this will become untenable
    Property.pluck(:address, :id).to_h
  end
end
