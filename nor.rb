require './web.rb'

def urls
	codes = []
	u = []

	beginning = "http://www.norwegian.com/us/booking/flight-tickets/farecalendar/?D_City="
	ending = "&A_City=OAK&TripType=1&D_Day=01&D_Month=201608&R_Day=01&R_Month=201608&AgreementCodeFK=-1&CurrencyCode=USD"

	File.open('./departures.txt').each do |l|
	  codes << l
	end

	codes.each do |code|
		url = beginning+code+ending
		u << url
	end

	return u
end


def run
	#JOBS LIST
	$b.goto 'http://www.norwegian.com/us/booking/flight-tickets/farecalendar/?D_City=OSLALL&A_City=OAK&TripType=1&D_Day=01&D_Month=201608&R_Day=01&R_Month=201608&AgreementCodeFK=-1&CurrencyCode=USD'
	puts price
	puts date
	puts departure
	all_arrivals.each do |option|
		puts option.value
	end

end

def report

	a = []

	days.each do |day|
		d = {}
		d.price << price(day)
		d.date << date(day)
		a << d
	end

	return a
end


def days
	$b.elements(:class => "fareCalDayTransit");
end

def price(el)
	el.div(:class => "fareCalPrice").text
end

def date(el)
	el.div(:class => "fareCalDate").text
end

def departure
	str = "- Select departure -"
	el = $b.element(:text => str).parent
	el.value
end

def all_departures
	str = "- Select departure -"
	el = $b.element(:text => str).parent
	el.options
end

def all_arrivals
	str = "- Select destination -"
	el = $b.element(:text => str).parent
	el.options
end

def set_departure(choice)
	str = "- Select departure -"
	el = $b.element(:text => str).parent
	el.select(choice)
end


def jobs
	if some_jobs?
		log 'Somethin.'
		sms 'Somethin.'

		name = "#{$i} jobs #{$k} .html"
		html = $b.html
		File.open(name, 'w') {|f| f.write html }

		if some_locked?
			log 'One or more locked.'
		end

		t = $b.tables[2]


		info = print_table t
		puts info
		sms info
	end
end




def main
	begin
		setup
		$b.goto(urls[0])
		puts report
	rescue Exception => e
		error(e)
	end
end

main


def check
	#find lowest price in hash
	#make string
	#sms string
	#if date between jul 30 and aug 10 buy ticket
end
