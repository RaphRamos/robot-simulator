# frozen_string_literal: true

Dir[File.dirname(__FILE__) + '/robot_simulator/*.rb'].sort.each do |file|
  require file
end
