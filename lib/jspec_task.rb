class JSpecTask
 
  def initialize()
  end
  
  def run(modified_files)
    detail = `jspec run --rhino`

    summary = make_summary(detail)

    return {
        :state => :success,
        :title => 'JSpec',
        :summary => summary,
        :detail => detail
      }
  end
  
  def make_summary(detail)
    return gist = detail.grep( /Passes:/ ).join(" / ").strip().gsub(/\e\[[0-9]+m?/, '')
  end
  
end