GraphINO 2.0 is a MATLAB application for Analog Arduino Data Acquisition.

This software was developed to facilitate the integration of Arduino with a computer through a graphical interface designed in the MATLAB programming environment for analog sensor data acquisition.

To use this program:

Load the adiosrv.ino or adiosrv.pde code available at C:\Program Files\Graphino\adiosrv into the Arduino IDE and then close the Arduino IDE.
Open the executable.
Specify the file path where you want to save the data by pressing the ... button.
Enter the COM port address of the Arduino.
Specify the number of sensors you want to measure and the desired time interval between measurements (in seconds).
Press the Connect button. It may take a while.
When ready to start measuring, press the Measure button. The data will be displayed in another window as graphs.
To stop data acquisition, press the Stop button. The acquired data will be saved as text files in table format in the specified file path.

Version 2.0 was developed to measure up to 16 analog sensors connected to an Arduino UNO or Arduino Mega.

Version 2.0 allows modifying the time interval between measurements during data acquisition.

Version 2.0 features PWM control on Arduino's digital pin 10, which can be adjusted during the experiment.

This application is intended for use in teaching and research activities.

Have fun!

Felipe Oliveira
oliveira.felipe00@gmail.com
