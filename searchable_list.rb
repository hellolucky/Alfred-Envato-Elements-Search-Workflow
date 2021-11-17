# encoding: UTF-8

require 'json'

searchable_list = { items: [] }

if ARGV[0].nil?
  puts searchable_list.to_json
  exit 0
end

categories = [
  { name: "All items", path: "all-items", sort_field: ENV["A_ALL_ITEMS"]&.to_i || -1 },
  { name: "Stock Video", path: "stock-video", sort_field: ENV["B_STOCK_VIDEO"]&.to_i || -1 },
  { name: "Video Templates", path: "video-templates", sort_field: ENV["C_VIDEO_TEMPLATES"]&.to_i || -1 },
  { name: "Music", path: "audio", sort_field: ENV["D_MUSIC"]&.to_i || -1 },
  { name: "Sound Effects", path: "sound-effects", sort_field: ENV["E_SOUND_EFFECTS"]&.to_i || -1 },
  { name: "Graphic Templates", path: "graphic-templates", sort_field: ENV["F_GRAPHIC_TEMPLATES"]&.to_i || -1 },
  { name: "Graphics", path: "graphics", sort_field: ENV["G_GRAPHICS"]&.to_i || -1 },
  { name: "Presentation Templates", path: "presentation-templates", sort_field: ENV["H_PRESENTATION_TEMPLATES"]&.to_i || -1 },
  { name: "Photos", path: "photos", sort_field: ENV["I_PHOTOS"]&.to_i || -1 },
  { name: "Fonts", path: "fonts", sort_field: ENV["J_FONTS"]&.to_i || -1 },
  { name: "Add-ons", path: "add-ons", sort_field: ENV["K_ADD_ONS"]&.to_i || -1 },
  { name: "Web Templates", path: "web-templates", sort_field: ENV["L_WEB_TEMPLATES"]&.to_i || -1 },
  { name: "CMS Templates", path: "cms-templates", sort_field: ENV["M_CMS_TEMPLATES"]&.to_i || -1 },
  { name: "WordPress", path: "wordpress", sort_field: ENV["N_WORDRPESS"]&.to_i || -1 },
  { name: "3D", path: "3d", sort_field: ENV["O_3D"]&.to_i || -1 }
]

categories.delete_if { |category| category[:sort_field] < 0 }
          .sort_by! { |category| category[:sort_field] }

categories.each do |category|
  searchable_list[:items] << {
    "title": "Search \"#{ARGV[0]}\" on #{category[:name]}",
    "subtitle": "https://elements.envato.com/#{category[:path]}/#{URI::encode(ARGV[0])}",
    "arg": "https://elements.envato.com/#{category[:path]}/#{ARGV[0]}",
    "match": ARGV[0]
  }
end

puts searchable_list.to_json