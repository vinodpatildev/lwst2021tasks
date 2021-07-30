#!/usr/bin/python3

print("content-type: application/json")
print()

print('''<style>
pre{
  color: black;
  font-weight: bold;
  font-size: 20px;
}
</style>
''')
import subprocess as sp
import cgi

fs = cgi.FieldStorage()

plate_number = fs.getvalue("plate-no")

import requests
import xmltodict
import json
def get_vehicle_info(plate_number):
    r = requests.get("https://www.regcheck.org.uk/api/reg.asmx/CheckIndia?RegistrationNumber={}&username=rto_user1".format(plate_number))
    data = xmltodict.parse(r.content)
    jdata = json.dumps(data)
    df = json.loads(jdata)
    df1 = json.loads(df['Vehicle']['vehicleJson'])
    return df1

output = get_vehicle_info(plate_number)

Description = output['Description']
RegistrationYear = output['RegistrationYear'] 
Company = output['CarMake']['CurrentTextValue']
Model = output['CarModel']['CurrentTextValue']
Variant = output['Variant']
EngineSize = output['EngineSize']['CurrentTextValue']
seats = output['NumberOfSeats']['CurrentTextValue']
inum = output['VechileIdentificationNumber']
enginenum = output['EngineNumber']
fueltype = output['FuelType']['CurrentTextValue']
regiDate = output['RegistrationDate']
owner = output['Owner']
fitness = output['Fitness']
insurance = output['Insurance']
PUCC = output['PUCC']
vehType = output['VehicleType']
location = output['Location']


print('''
<div class="row mt-2">
	<div class="section-title">
          <h2>Vehicle Details</h2>
          <p>Details Fetched</p>
        </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Description</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Registration Year</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Company</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Model</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Variant</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Engine Size</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Number of seats</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Vehicke Identification Number</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Engine Number</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Fuel-Type</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Registration Date</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Owner Name</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Fitness</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Insurance</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">PUCC</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Vehicle Type</a></h4>
            <p class="description">{}</p>
          </div>
          <div class="col-lg-4 col-md-6 icon-box">
            <div class="icon"><i class="bi bi-briefcase"></i></div>
            <h4 class="title"><a href="">Location</a></h4>
            <p class="description">{}</p>
          </div>
                   
          
        </div>
'''.format(Description, RegistrationYear, Company, Model, Variant, EngineSize, seats, inum, enginenum, fueltype, regiDate, owner, fitness, insurance, PUCC,vehType,location))