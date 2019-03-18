module PdfExtensions
  module Patches::PdfDisplayExternalImages
    def get_image_filename(attrname)
      possible_filename = super
      return super if super

      attrname_utf8 = Redmine::CodesetUtil.to_utf8(attrname, "UTF-8")
      if attrname_utf8 =~ /[^-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]%]/n
        return URI.encode(attrname_utf8)
      else
        return attrname_utf8
      end 
    end
  end
end