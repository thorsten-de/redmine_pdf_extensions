module PdfExtensions

  SCALE_ABSOLUTE_PIXELS = ->(n) {n}
  SCALE_RELATIVE_PROCENT = ->(p) { 9 * p }
  EXTENSION_PATTERNS = {
    relative_width: [/width:\s*(\d+)%;/, SCALE_RELATIVE_PROCENT],
    absoulte_width: [/width:\s*(\d+);/, SCALE_ABSOLUTE_PIXELS],
    relative_height: [/height:\s*(\d+)%;/, SCALE_RELATIVE_PROCENT],
    absoulte_height: [/height:\s*(\d+);/, SCALE_ABSOLUTE_PIXELS]
  }

  def self.evaluate_width_from_style(style)
    dimensions = EXTENSION_PATTERNS.transform_values do |pattern, scaler| 
      pattern.match(style) do |match|
        scaler.(match[1].to_i)
      end
    end
    [dimensions[:relative_width] || dimensions[:absoulte_width], 
     dimensions[:relative_height] || dimensions[:absoulte_height]]
  end

  module Patches::PdfEvaluateImageSize
    def RDMwriteFormattedCell(w, h, x, y, txt='', attachments=[], border=0, ln=1, fill=0)
      doc = Nokogiri::HTML(txt)

      images = doc.css('img')
      
      images.each do |image|
        width, height = PdfExtensions::evaluate_width_from_style(image['style'])
        image.remove_attribute('style')
        image['width'] = width if width
        image['height'] = height if height
      end
      
      new_html = doc.at_css('html body').children().to_html
      p(new_html)
      super(w, h, x, y, new_html, attachments, border, ln, fill)
    end
  end
end