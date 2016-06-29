require 'russian'

class String

  def as_html
    formatter = Gilenson.new
    formatter.configure!(:skip_attr => true)
    self.to_s.gsub!(/&(laquo|raquo|quot);/, '"')
    formatter.process(self).html_safe
  end

  def slugged
    Russian::transliterate(self.to_s).downcase.gsub(/\s+/, '-').gsub(/«|»|,|\./, '').gsub(/-+/, '-')
  end

end
