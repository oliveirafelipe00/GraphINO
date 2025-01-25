GraphINO Project
Version 2.0

This software was developed to facilitate the integration of Arduino with a computer through a graphical interface designed in the Matlab programming environment.

To use this program:

GraphINO requires MATLAB Runtime R2015a (https://www.mathworks.com/products/compiler/matlab-runtime.htm)

GraphINO necessita do MATLAB Runtime R2015a instalado (https://www.mathworks.com/products/compiler/matlab-runtime.html)

Windows 64-bits:
https://ssd.mathworks.com/supportfiles/downloads/R2015a/deployment_files/R2015a/installers/win64/MCR_R2015a_win64_installer.exe

Windows 32-bits:
https://ssd.mathworks.com/supportfiles/downloads/R2015a/deployment_files/R2015a/installers/win32/MCR_R2015a_win32_installer.exe

Linux 64-bits:
https://ssd.mathworks.com/supportfiles/downloads/R2015a/deployment_files/R2015a/installers/glnxa64/MCR_R2015a_glnxa64_installer.zip

MAC 64-bits:
https://ssd.mathworks.com/supportfiles/downloads/R2015a/deployment_files/R2015a/installers/maci64/MCR_R2015a_maci64_installer.zip

Load the adiosrv.ino or adiosrv.pde code avaiable at C:\Program Files\Graphino\adiosrv into the Arduino IDE and then close the Arduino IDE.

Open the executable GraphINO.exe.

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
