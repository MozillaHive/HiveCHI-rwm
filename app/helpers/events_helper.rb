module EventsHelper
  def event_type_image_tag(type)
    image_tag(
      "https://703776390ca6a57878ac07d8581c71c708895809.googledrive.com/host/0B-EZWDUirQ46fjQtUzN1VG80eWdzdERtYjMzcTg3S19VeGlWR3FfUGJpOEFEZmtVQmh4SFk/Assets/icons/#{type}.png",
      class: "ui-li-icon"
    )
  end
end
