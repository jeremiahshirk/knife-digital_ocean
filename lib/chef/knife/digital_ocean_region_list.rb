# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require File.expand_path('../digital_ocean_base', __FILE__)

class Chef
  class Knife
    class DigitalOceanRegionList < Knife
      include Knife::DigitalOceanBase

      banner 'knife digital_ocean region list (options)'

      def run
        $stdout.sync = true

        validate!

        region_list = [
          h.color('ID',   :bold),
          h.color('Name', :bold)
        ]

        regions = client.regions.list.regions

        regions.sort! do |a, b|
          a.name.to_i <=> b.name.to_i
        end

        regions.each do |region|
          region_list << region.id.to_s
          region_list << region.name.to_s
        end

        puts h.list(region_list, :uneven_columns_across, 2)
      end
    end
  end
end
