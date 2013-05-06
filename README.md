WiFi Cookie Jar
	Design
	Khanh Nguyen, 311253865 and Kevin Nguyen, 311254039

WiFi Cookie Jar System Design
	The design of the WiFi Cookie Jar system will consist of the following:
	A cookie jar that is light in weight so that it would not affect the load cell output too much. The lid of the cookie jar will also have its own circuit which will determine when data should be transmitted or not.
	A load cell circuit to measure the weight of the cookie jar and its contents.
	An Arduino DUE as the microcontroller that will process and send the measurements between different modules of the cookie jar system.
	A WiFi Shield that will receive data from the Arduino and transmit the data to the web server via a HTTP request to the Internet. The WiFi shield will connect to a wireless modem with a preset SSID and WPA2 key which is editable in the .ino file. 
	A web server that will run a web application that will be implemented using Ruby on Rails.
	A PostgreSQL database that will store the data sent from the physical components of the system. The data from this database will be displayed on the web application. 

	Since the system is connected to the Internet both local and external users will be able to access the web application online.

Circuit Design
	The load cell and the instrumentation amplifier(INA126PA) are both connected to the 5v source of the Arduino. The output of the load cell is fed into the instrumentation amplifier which has a gain of G = 5 + 80kRg, where Rg is the chosen 68 resistor. This sets G = 1176.47 V/V. The amplified signal (pin 6 of INA126PA) is then connected to A0(analog input) of the Arduino for processing. Pin 6 of the INA126PA is also connected to a zener diode with Vz = 3.3v to limit the signal, this will prevent damage to the Arduino A0 pin which can only tolerate a maximum voltage of 3.3v.The Arduino then sends the information over the internet through the WiFi module which is connected to  RX1 and TX1 of the Arduino. 

Code Design
	The Arduino code for the WiFi Cookie Jar takes an input from the loadcell (i.e. the weight of the cookie jar and its contents). If there has been a change in the weight then it call the sendDataToServer function which utilises the WiFi shield and sends the data to the web application.

		char * ssid = “WIFI-MODEM”;
		char * wpa_key = “password123”;
		char * url = “http://cookiejar.com/update_jar”
		float currentWeight = 0;

		//these values are to calibrate the load cell
		float loadA = 0.1 //kg
		int avalA = 200; //value read in with known load on

		float loadB = 0.5 //kg
		int avalB = 500; //value read in with known load on

		void setup() {
			// connect to wireless network
			wifiShield.connect(ssid, wpa_key);
			// this should provide warning to the user if the connection has been 
		      // established	
		}

		void loop() {
			int ain = analogRead(0);
			
			//take in the data from the load cell
			float newWeight = calculateWeight(ain);
			
			if (currentWeight != newWeight){
				currentWeight = newWeight;
				sendDataToServer(currentWeight);
		}
		  	
		}

		float calculateWeight(float ain){
		float weight = mapFloat(ain, avalA, avalB, loadA, loadB);
		//calculate the weight from the data here
			return weight;
		}

		//converts analog value to KG
		float mapFloat(float data){
			return (ain - avalA)*(loadB-loadA)/(avalB - avalA) + loadA;
		}

		int sendDataToServer(float weight){
		if (getRequest(url, weight)) //returns boolean,
			return 1;		     //true if success, false if fail
		else
			return 0;
		}

Web Application Design 
	The WiFi Cookie Jar web application will use Ruby on Rails which uses the Ruby programming language as the backend and HTML and Javascript (jQuery and AJAX) for the frontend. 

	Simple headings
	Dynamically generated image of a cookie that represents the level of the cookie jar. The lower the level gets, the more bites will be taken out of the cookie.
	A dynamic progress bar that represents the level of the cookie jar. It will utilize the Twitter Bootstrap since the premade elements are convenient. 
	Figure 3: Mock up of the initial design of the web application

	The dynamically generated cookie image and progress bar will be controlled by Javascript which makes an AJAX call to the Rails controller to see if there’s been a change in the level of the cookie jar and adjusts accordingly.

	Since the data will be stored in a database it will be possible to do further extensions such a historical graph of the level of the jar over time or a calorie counter which can be easily computed on the web application.
