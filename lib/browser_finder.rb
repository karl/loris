require 'win32/registry'

class BrowserFinder
  
  def initialize
    @ie = '"C:/Program Files/Internet Explorer/iexplore.exe" "%1"'
  end
  
  def getDefault
    browser = getBrowserFromRegistry()
    return browser != '' ? browser : @ie
  end
  
  def getBrowserFromRegistry
    
      Win32::Registry::HKEY_CLASSES_ROOT.open('http\shell\open\command') do |reg|
          reg_typ, reg_val = reg.read('')          
          return reg_val
      end
    
  end
  
end