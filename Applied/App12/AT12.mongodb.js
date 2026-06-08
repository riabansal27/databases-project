// Student ID: 34267433
// Student Name: Ria Bansal
// Tutor: Dwi Rahayu

// ===================================================================================
// DO NOT modify or remove any of the comments below (items marked with //)
// Do not use .pretty() in your code, it is not required
// ===================================================================================

// Use (connect to) your database - you MUST update xyz001
// with your authcate username
use("rban0019");

// List all collections
db.getCollectionNames();

// Drop at_dronerental collection
db.at_dronerental.drop();

// Create at_dronerental collection and add documents
db.at_dronerental.insertMany([
  {"drone_id":100,"type":{"code":"DMA2","model":"DJI Mavic Air 2 Flymore Combo","manufacturer":"DJI Da-Jiang Innovations"},"carrying_capacity":0,"pur_date":"13-Jan-2021","pur_price":1494,"total_flighttime":100,"cost_per_hour":15,"RentalInfo":[{"rent_no":1,"bond":100,"rent_out":"20-Feb-2021 08:47:00","rent_in":"20-Feb-2021 18:53:00","custdetails":"1:Manolo WAREN"},{"rent_no":4,"bond":100,"rent_out":"22-Feb-2021 14:37:00","rent_in":"25-Feb-2021 09:31:00","custdetails":"4:Raychel ROUSSEL"}]},
  {"drone_id":101,"type":{"code":"DMA2","model":"DJI Mavic Air 2 Flymore Combo","manufacturer":"DJI Da-Jiang Innovations"},"carrying_capacity":0,"pur_date":"13-Jan-2021","pur_price":1494,"total_flighttime":60,"cost_per_hour":15,"RentalInfo":[{"rent_no":2,"bond":100,"rent_out":"21-Feb-2021 12:01:00","rent_in":"22-Feb-2021 12:06:00","custdetails":"2:Lennard DUDGEON"},{"rent_no":5,"bond":100,"rent_out":"25-Feb-2021 09:13:00","rent_in":"25-Feb-2021 18:58:00","custdetails":"5:Jamill FLANNERY"},{"rent_no":10,"bond":100,"rent_out":"10-Mar-2021 08:30:00","rent_in":"18-Mar-2021 15:23:00","custdetails":"1:Manolo WAREN"}]},
  {"drone_id":102,"type":{"code":"DSPA","model":"DJI Spark","manufacturer":"DJI Da-Jiang Innovations"},"carrying_capacity":2,"pur_date":"13-Jan-2021","pur_price":872.44,"total_flighttime":45.5,"cost_per_hour":9,"RentalInfo":[{"rent_no":3,"bond":100,"rent_out":"22-Feb-2021 13:47:00","rent_in":"23-Feb-2021 13:51:00","custdetails":"3:Christiana BRIGHTEY"}]},
  {"drone_id":103,"type":{"code":"DIN2","model":"DJI Inspire 2","manufacturer":"DJI Da-Jiang Innovations"},"carrying_capacity":5,"pur_date":"13-Jan-2021","pur_price":5300,"total_flighttime":200,"cost_per_hour":55,"RentalInfo":[{"rent_no":7,"bond":200,"rent_out":"01-Mar-2021 11:03:00","rent_in":"02-Mar-2021 18:36:00","custdetails":"7:Gannon BRENNEKE"},{"rent_no":8,"bond":200,"rent_out":"03-Mar-2021 13:47:00","rent_in":"04-Mar-2021 16:33:00","custdetails":"8:Robbyn LINTALL"},{"rent_no":9,"bond":200,"rent_out":"06-Mar-2021 08:55:00","rent_in":"10-Mar-2021 14:46:00","custdetails":"9:Townsend DUNLAP"},{"rent_no":15,"bond":200,"rent_out":"01-May-2021 08:34:00","rent_in":"02-May-2021 14:15:00","custdetails":"8:Robbyn LINTALL"},{"rent_no":16,"bond":200,"rent_out":"03-May-2021 08:09:00","rent_in":"10-May-2021 16:15:00","custdetails":"9:Townsend DUNLAP"}]},
  {"drone_id":111,"type":{"code":"PAPR","model":"Parrot Pro","manufacturer":"Parrot"},"carrying_capacity":5,"pur_date":"20-Mar-2021","pur_price":4200,"total_flighttime":100,"cost_per_hour":45,"RentalInfo":[{"rent_no":11,"bond":150,"rent_out":"26-Apr-2021 10:21:00","rent_in":"28-Apr-2021 14:13:00","custdetails":"10:Buddy JUDEN"}]},
  {"drone_id":112,"type":{"code":"PAPR","model":"Parrot Pro","manufacturer":"Parrot"},"carrying_capacity":5,"pur_date":"20-Mar-2021","pur_price":4200,"total_flighttime":40,"cost_per_hour":45,"RentalInfo":[{"rent_no":12,"bond":150,"rent_out":"26-Apr-2021 10:28:00","rent_in":"27-Apr-2021 17:19:00","custdetails":"11:Norrie SEVERY"},{"rent_no":17,"bond":150,"rent_out":"03-May-2021 09:45:00","rent_in":"07-May-2021 16:53:00","custdetails":"14:Gwynne REDER"}]},
  {"drone_id":113,"type":{"code":"PAPR","model":"Parrot Pro","manufacturer":"Parrot"},"carrying_capacity":5,"pur_date":"20-Mar-2021","pur_price":4000,"total_flighttime":150,"cost_per_hour":45,"RentalInfo":[{"rent_no":13,"bond":150,"rent_out":"28-Apr-2021 10:09:00","rent_in":"29-Apr-2021 17:25:00","custdetails":"12:Beverie HUNTRISS"},{"rent_no":18,"bond":150,"rent_out":"03-May-2021 09:55:00","rent_in":"12-May-2021 17:53:00","custdetails":"15:Farly HARCOMBE"}]},
  {"drone_id":117,"type":{"code":"PAPR","model":"Parrot Pro","manufacturer":"Parrot"},"carrying_capacity":5,"pur_date":"20-Mar-2021","pur_price":4000,"total_flighttime":100.5,"cost_per_hour":45,"RentalInfo":[{"rent_no":14,"bond":150,"rent_out":"28-Apr-2021 09:11:00","rent_in":"05-May-2021 16:55:00","custdetails":"9:Townsend DUNLAP"}]},
  {"drone_id":118,"type":{"code":"SWPS","model":"SwellPro Spry","manufacturer":"SwellPro"},"carrying_capacity":0,"pur_date":"01-Apr-2021","pur_price":1599,"total_flighttime":56.3,"cost_per_hour":16,"RentalInfo":[{"rent_no":19,"bond":180,"rent_out":"17-May-2021 09:02:00","rent_in":"18-May-2021 15:30:00","custdetails":"16:Aline HAREWOOD"},{"rent_no":20,"bond":180,"rent_out":"19-May-2021 09:44:00","rent_in":"23-May-2021 17:34:00","custdetails":"17:Muriel ZAMBONINI"},{"rent_no":21,"bond":180,"rent_out":"28-May-2021 09:23:00","rent_in":"29-May-2021 16:52:00","custdetails":"18:Emory SISLEY"},{"rent_no":22,"bond":180,"rent_out":"01-Jun-2021 08:52:00","rent_in":"07-Jun-2021 17:49:00","custdetails":"9:Townsend DUNLAP"},{"rent_no":25,"bond":180,"rent_out":"23-Aug-2022 08:52:00","rent_in":null,"custdetails":"18:Emory SISLEY"}]},
  {"drone_id":119,"type":{"code":"DIN2","model":"DJI Inspire 2","manufacturer":"DJI Da-Jiang Innovations"},"carrying_capacity":5,"pur_date":"01-Apr-2022","pur_price":5600.8,"total_flighttime":10.2,"cost_per_hour":60,"RentalInfo":[{"rent_no":23,"bond":250,"rent_out":"21-Aug-2022 10:04:00","rent_in":null,"custdetails":"5:Jamill FLANNERY"}]},
  {"drone_id":120,"type":{"code":"DIN2","model":"DJI Inspire 2","manufacturer":"DJI Da-Jiang Innovations"},"carrying_capacity":5,"pur_date":"01-Apr-2022","pur_price":4200,"total_flighttime":25.8,"cost_per_hour":60,"RentalInfo":[{"rent_no":24,"bond":150,"rent_out":"22-Aug-2022 08:25:00","rent_in":null,"custdetails":"6:Serene PABST"}]}
]);

// Show all documents added
db.at_dronerental.find();

// Show all drones manufactured by "Parrot" which have a total flight time
// greater than 10.  Display the drone id, the type of model, the purchase date 
// and total flight time in your output.
db.at_dronerental.find(
  {
    "type.manufacturer": "Parrot",
    "total_flighttime": { $gt: 10 }
  },
  {
    "_id": 0,
    "drone_id": 1,
    "type.model": 1,
    "pur_date": 1,
    "total_flighttime": 1
  }
);

// End script - DO NOT REMOVE

