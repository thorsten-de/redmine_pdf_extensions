module PdfExtensions::Patches::PdfAttachForExternalFiles
  def attach(attachments, filename, encoding)
    # Original-Routine machen lassen. Wenn sie ein Attachment findet, einfach zurückgeben.
    attachment = super(attachments, filename, encoding)
    return attachment if attachment

    # Es wurde kein Attachment innerhalb des Tickets gefunden. Weitersuchen...

    # Entspricht der Dateiname einer Attachment-URL?  Die ID wird als erste Gruppe gematcht.
    /attachments\/download\/(\d+)\/.*\.(gif|jpeg|jpg|png)\z/.match(filename) do |match|
      # Das Attachment laden, deren ID gematcht wurde.
      # ACHTUNG: match[0] ist der gesamte Match, match[1] daher die erste Gruppe.
      attachment = Attachment.find(match[1])

      if attachment && attachment.readable? && attachment.visible?
        return attachment
      else
        return nil
      end
    end

    # Es passte kein Attachment zum Dateinamen. Die Datei wird nicht in de PDF eingebunden.
    nil
  end
end