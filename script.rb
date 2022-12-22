require 'watir'
require 'open-uri'
require 'rmagick'
require 'net/ftp'

BROWSER_TYPE = :chrome
JAVASCRIPT_CODE_THAT_REMOVES_ELEMENT = "document.getElementById('onetrust-consent-sdk').remove()"
CONFIG_FILE_NAME = "config.yml"
FTP_CONFIG_FILE_NAME = "ftp_config.yml"

config = YAML.load_file(CONFIG_FILE_NAME)
SCREENSHOT_FILE_NAME = config["screenshot_file_name"]
CROPPED_IMAGE_FILE_NAME = config["cropped_image_file_name"]
CROP_X, CROP_Y = config["crop_x"], config["crop_y"]
CROP_WIDTH, CROP_HEIGHT = config["crop_width"], config["crop_height"]
URL_PREFIX = "https://www.trustpilot.com/review/"
COMPANY_NAME = config["company_name"]

ftp_config = YAML.load_file(FTP_CONFIG_FILE_NAME)
FTP_HOST = ftp_config["host"]
FTP_USER = ftp_config["user"]
FTP_PASSWORD = ftp_config["password"]

# # # generated url 
# url = "#{URL_PREFIX}#{COMPANY_NAME}"

# # renders webpage from url and saves it as an image
# puts "Opening browser..."
# browser = Watir::Browser.new(BROWSER_TYPE, headless: true)

# puts "Going to url..."
# browser.goto url

# puts "Clicking on the button to close the modal..."
# #button_to_close_modal = "onetrust-accept-btn-handler"
# #browser.button(id: button_to_close_modal).click
# browser.execute_script(JAVASCRIPT_CODE_THAT_REMOVES_ELEMENT)

# puts "Saving screenshot..."
# browser.screenshot.save SCREENSHOT_FILE_NAME

# puts "Closing browser..."
# browser.close

# puts "Screenshot saved!"

# # open screenshot and cut out the part with the reviews
# puts "Opening screenshot..."
# screenshot = Magick::Image.read(SCREENSHOT_FILE_NAME).first

# # crop the image
# puts "Cropping image..."
# cropped_image = screenshot.crop(CROP_X, CROP_Y, CROP_WIDTH, CROP_HEIGHT)

# #save the cropped image
# puts "Saving cropped image..."
# cropped_image.write(CROPPED_IMAGE_FILE_NAME)

# upload the cropped image to the ftp server
puts "Uploading image to ftp server..."

puts FTP_HOST
# Connect to the FTP host
ftp = Net::FTP.new(FTP_HOST)
ftp.passive = true

# Log in with a username and password
ftp.login(FTP_USER, FTP_PASSWORD)

# Change to the desired directory
ftp.chdir('/public_html')

# Open the file and upload it
File.open('/path/to/local/file.txt', 'rb') do |file|
  ftp.putbinaryfile(file)
end

# Close the connection
ftp.close
