require 'watir-webdriver'
require './util.rb'

def print_table(t)
	r = ""
	t.trs.each do |tr|
		tr.tds.each do |td|
			r << " " << td.text
		end
	end
	return r
end

def identify(el)
	puts el.inner_html
	puts el.tag_name
	puts el.text
	puts el.id
	puts el.name
	puts el.src
	puts el.value
end

def click_first
	btn = $b.inputs(:type => 'image')[0]
	if btn.present?
		log 'BUTTON'
		identify btn
		btn.click
	end
end


def setup
	#BROWSER
	$b = Watir::Browser.new

end

def wait
	sleep 5
	log $k
end

def error(e)
	log e
	close
end

def close
	$b.close
	log 'CLOSED BROWSER'
	log $i
end
