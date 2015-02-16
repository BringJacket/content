module Travel
  module GeoUtils
    def sort_geometry!(geom)
      geom['coordinates'].sort_by! { |c| Time.parse(c[2]) } if geom && geom['type'] == 'LineString'
      geom
    end
  end
end