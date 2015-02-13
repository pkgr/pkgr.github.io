require 'html/pipeline/filter'

class AddCssClassToTableFilter < HTML::Pipeline::Filter

  def call
    doc.search("table").each do |table|
      table['class'] = "pure-table pure-table-horizontal pure-table-striped"
    end
    doc
  end

end
