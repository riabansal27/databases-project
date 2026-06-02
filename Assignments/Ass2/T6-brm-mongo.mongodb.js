// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T6-brm-mongo.mongodb.js

// Student ID: 34267433
// Student Name:Ria Bansal

// ===================================================================================
// DO NOT modify or remove any of the comments below (items marked with //)
// Do not use .pretty() in your code, it is not required
//
// -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
// In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
// ===================================================================================

// Use (connect to) your database - you MUST update xyz001
// with your authcate username

use("rban0019");

// (b)
// Drop collection
db.brm_customers.drop();

// Create collection and insert documents
db.brm_customers.insertMany([
{"_id":1,"customer_name":"Michael Benjamin","customer_business":"FreshBox","customer_address":"55 Lonsdale Street, Melbourne, 3008","customer_phone":"0478901017","customer_stats":{"number_of_quotes":6,"number_of_jobs":6,"total_paid_jobcost":"$5680.00","total_unpaid_jobcost":"$1550.00"},"quotes":[{"quote_no":20,"quote_prepared_on":"01-May-2026","preferred_start_date":"10-May-2026","start_location":"55 Lonsdale Street, Melbourne","end_location":"Caulfield VIC 3162","quote_cost":"$1200.00","assigned_to_job":"Y","job_cost":"$1200.00"},{"quote_no":21,"quote_prepared_on":"02-May-2026","preferred_start_date":"12-May-2026","start_location":"Melbourne CBD VIC 3000","end_location":"St Kilda VIC 3182","quote_cost":"$850.00","assigned_to_job":"Y","job_cost":"$900.00"},{"quote_no":22,"quote_prepared_on":"03-May-2026","preferred_start_date":"15-May-2026","start_location":"Dandenong VIC 3175","end_location":"Frankston VIC 3199","quote_cost":"$1500.00","assigned_to_job":"Y","job_cost":"$1550.00"},{"quote_no":23,"quote_prepared_on":"04-May-2026","preferred_start_date":"18-May-2026","start_location":"Geelong VIC 3220","end_location":"Ballarat VIC 3350","quote_cost":"$2200.00","assigned_to_job":"Y","job_cost":"$2200.00"},{"quote_no":24,"quote_prepared_on":"05-May-2026","preferred_start_date":"20-May-2026","start_location":"Richmond VIC 3121","end_location":"Hawthorn VIC 3122","quote_cost":"$600.00","assigned_to_job":"Y","job_cost":"$600.00"},{"quote_no":25,"quote_prepared_on":"06-May-2026","preferred_start_date":"22-May-2026","start_location":"Sunshine VIC 3020","end_location":"Footscray VIC 3011","quote_cost":"$750.00","assigned_to_job":"Y","job_cost":"$780.00"}]},
{"_id":2,"customer_name":"James","customer_business":"J Wood and Gravel","customer_address":"15 George Street, Sydney, 2000","customer_phone":"0412345001","customer_stats":{"number_of_quotes":6,"number_of_jobs":6,"total_paid_jobcost":"$3310.00","total_unpaid_jobcost":"$1130.00"},"quotes":[{"quote_no":26,"quote_prepared_on":"01-May-2026","preferred_start_date":"11-May-2026","start_location":"Preston VIC 3072","end_location":"Reservoir VIC 3073","quote_cost":"$550.00","assigned_to_job":"Y","job_cost":"$550.00"},{"quote_no":27,"quote_prepared_on":"02-May-2026","preferred_start_date":"14-May-2026","start_location":"Epping VIC 3076","end_location":"Craigieburn VIC 3064","quote_cost":"$900.00","assigned_to_job":"Y","job_cost":"$950.00"},{"quote_no":28,"quote_prepared_on":"03-May-2026","preferred_start_date":"16-May-2026","start_location":"Werribee VIC 3030","end_location":"Hoppers Crossing VIC 3029","quote_cost":"$650.00","assigned_to_job":"Y","job_cost":"$650.00"},{"quote_no":29,"quote_prepared_on":"04-May-2026","preferred_start_date":"19-May-2026","start_location":"Sunbury VIC 3429","end_location":"Melton VIC 3337","quote_cost":"$1100.00","assigned_to_job":"Y","job_cost":"$610.00"},{"quote_no":30,"quote_prepared_on":"05-May-2026","preferred_start_date":"21-May-2026","start_location":"Glen Waverley VIC 3150","end_location":"Wheelers Hill VIC 3150","quote_cost":"$580.00","assigned_to_job":"Y","job_cost":"$1100.00"},{"quote_no":31,"quote_prepared_on":"06-May-2026","preferred_start_date":"24-May-2026","start_location":"Springvale VIC 3171","end_location":"Noble Park VIC 3174","quote_cost":"$700.00","assigned_to_job":"Y","job_cost":"$580.00"}]},
{"_id":3,"customer_name":"Brook","customer_business":"Western Chocolatery","customer_address":"23 Murray Street, Perth, 6000","customer_phone":"0445678004","customer_stats":{"number_of_quotes":6,"number_of_jobs":6,"total_paid_jobcost":"$3380.00","total_unpaid_jobcost":"$640.00"},"quotes":[{"quote_no":32,"quote_prepared_on":"02-May-2026","preferred_start_date":"12-May-2026","start_location":"Coburg VIC 3058","end_location":"Brunswick VIC 3056","quote_cost":"$620.00","assigned_to_job":"Y","job_cost":"$700.00"},{"quote_no":33,"quote_prepared_on":"03-May-2026","preferred_start_date":"14-May-2026","start_location":"Kew VIC 3101","end_location":"Camberwell VIC 3124","quote_cost":"$800.00","assigned_to_job":"Y","job_cost":"$620.00"},{"quote_no":34,"quote_prepared_on":"04-May-2026","preferred_start_date":"17-May-2026","start_location":"Malvern VIC 3144","end_location":"Toorak VIC 3142","quote_cost":"$750.00","assigned_to_job":"Y","job_cost":"$800.00"},{"quote_no":35,"quote_prepared_on":"05-May-2026","preferred_start_date":"20-May-2026","start_location":"Doncaster VIC 3108","end_location":"Manningham VIC 3109","quote_cost":"$920.00","assigned_to_job":"Y","job_cost":"$750.00"},{"quote_no":36,"quote_prepared_on":"06-May-2026","preferred_start_date":"22-May-2026","start_location":"Essendon VIC 3040","end_location":"Moonee Ponds VIC 3039","quote_cost":"$640.00","assigned_to_job":"Y","job_cost":"$640.00"},{"quote_no":37,"quote_prepared_on":"07-May-2026","preferred_start_date":"26-May-2026","start_location":"Carlton VIC 3053","end_location":"Fitzroy VIC 3065","quote_cost":"$510.00","assigned_to_job":"Y","job_cost":"$510.00"}]},
{"_id":4,"customer_name":"Alexander Noah","customer_business":"-","customer_address":"56 Bourke Street, Melbourne, 3001","customer_phone":"0478901007","customer_stats":{"number_of_quotes":6,"number_of_jobs":3,"total_paid_jobcost":"$1910.00","total_unpaid_jobcost":"-"},"quotes":[{"quote_no":38,"quote_prepared_on":"03-May-2026","preferred_start_date":"13-May-2026","start_location":"Moorabbin VIC 3189","end_location":"Brighton VIC 3186","quote_cost":"$880.00","assigned_to_job":"Y","job_cost":"$510.00"},{"quote_no":39,"quote_prepared_on":"04-May-2026","preferred_start_date":"15-May-2026","start_location":"Sandringham VIC 3191","end_location":"Cheltenham VIC 3192","quote_cost":"$710.00","assigned_to_job":"Y","job_cost":"$710.00"},{"quote_no":40,"quote_prepared_on":"05-May-2026","preferred_start_date":"18-May-2026","start_location":"Mentone VIC 3194","end_location":"Mordialloc VIC 3195","quote_cost":"$690.00","assigned_to_job":"Y","job_cost":"$690.00"},{"quote_no":41,"quote_prepared_on":"06-May-2026","preferred_start_date":"21-May-2026","start_location":"Oakleigh VIC 3166","end_location":"Clayton South VIC 3169","quote_cost":"$480.00","assigned_to_job":"N","job_cost":"-"},{"quote_no":42,"quote_prepared_on":"07-May-2026","preferred_start_date":"24-May-2026","start_location":"Mulgrave VIC 3170","end_location":"Notting Hill VIC 3168","quote_cost":"$520.00","assigned_to_job":"N","job_cost":"-"},{"quote_no":43,"quote_prepared_on":"08-May-2026","preferred_start_date":"27-May-2026","start_location":"Burwood VIC 3125","end_location":"Camberwell VIC 3124","quote_cost":"$610.00","assigned_to_job":"N","job_cost":"-"}]},
{"_id":5,"customer_name":"Jack Ethan","customer_business":"-","customer_address":"61 Ann Street, Brisbane, 4101","customer_phone":"0434567013","customer_stats":{"number_of_quotes":6,"number_of_jobs":0,"total_paid_jobcost":"-","total_unpaid_jobcost":"-"},"quotes":[{"quote_no":44,"quote_prepared_on":"04-May-2026","preferred_start_date":"14-May-2026","start_location":"Rowville VIC 3178","end_location":"Lysterfield VIC 3156","quote_cost":"$630.00","assigned_to_job":"N","job_cost":"-"},{"quote_no":45,"quote_prepared_on":"05-May-2026","preferred_start_date":"16-May-2026","start_location":"Knoxfield VIC 3180","end_location":"Scoresby VIC 3179","quote_cost":"$450.00","assigned_to_job":"N","job_cost":"-"},{"quote_no":46,"quote_prepared_on":"06-May-2026","preferred_start_date":"19-May-2026","start_location":"Boronia VIC 3155","end_location":"Wantirna VIC 3152","quote_cost":"$720.00","assigned_to_job":"N","job_cost":"-"},{"quote_no":47,"quote_prepared_on":"07-May-2026","preferred_start_date":"22-May-2026","start_location":"Ringwood VIC 3134","end_location":"Mitcham VIC 3132","quote_cost":"$800.00","assigned_to_job":"N","job_cost":"-"},{"quote_no":48,"quote_prepared_on":"08-May-2026","preferred_start_date":"25-May-2026","start_location":"Vermont VIC 3133","end_location":"Nunawading VIC 3131","quote_cost":"$590.00","assigned_to_job":"N","job_cost":"-"},{"quote_no":49,"quote_prepared_on":"09-May-2026","preferred_start_date":"26-May-2026","start_location":"Mitcham VIC 3132","end_location":"Donvale VIC 3111","quote_cost":"$400.00","assigned_to_job":"N","job_cost":"-"}]},
{"_id":18,"customer_name":"Victoria Ella","customer_business":"Flintstone Store","customer_address":"94 Henley Beach Road, Adelaide, 5095","customer_phone":"0401234020","customer_stats":{"number_of_quotes":1,"number_of_jobs":0,"total_paid_jobcost":"-","total_unpaid_jobcost":"-"},"quotes":[{"quote_no":300,"quote_prepared_on":"17-May-2026","preferred_start_date":"25-May-2026","start_location":"29 Kuranda Road, Adelaide SA 5030","end_location":"9 Albatros Drive, Mount Gambier SA 5270","quote_cost":"$1000.00","assigned_to_job":"N","job_cost":"-"}]}
]);

// List all documents you added
db.brm_customers.find({});


// (c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// List all customers who have made at least 2 quotes and live in Melbourne
// Display customer id, full name, address, contact number, 
// number of quotes, number of jobs, total paid and unpaid job cost
db.brm_customers.find(
    {
        "$and": [
            {"customer_address": {"$regex": "Melbourne"}},
            {"customer_stats.number_of_quotes": {"$gte": 2}}
        ]
    },
    {
        "_id": 1,
        "customer_name": 1,
        "customer_address": 1,
        "customer_phone": 1,
        "customer_stats.number_of_quotes": 1,
        "customer_stats.number_of_jobs": 1,
        "customer_stats.total_paid_jobcost": 1,
        "customer_stats.total_unpaid_jobcost": 1
    }
);

// (d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// (d)
// (i) Add new customer Patrick Bosse with customer ID 1001
db.brm_customers.insertOne({
    "_id": 1001,
    "customer_name": "Patrick Bosse",
    "customer_business": "-",
    "customer_address": "10 Collins Street, Melbourne, 3000",
    "customer_phone": "0411999888",
    "customer_stats": {
        "number_of_quotes": 0,
        "number_of_jobs": 0,
        "total_paid_jobcost": "-",
        "total_unpaid_jobcost": "-"
    },
    "quotes": []
});

// Show the customer details
db.brm_customers.find({"_id": {"$eq": 1001}});

// (ii) Add new quote for Patrick Bosse - quote number 2002
// Quote to transport bottled drinks from Adelaide SA to Melbourne VIC
// Quote cost $3200.00, immediately assigned to job with same cost, payment made
db.brm_customers.updateOne(
    {"_id": {"$eq": 1001}},
    {
        "$set": {
            "customer_stats.number_of_quotes": 1,
            "customer_stats.number_of_jobs": 1,
            "customer_stats.total_paid_jobcost": "$3200.00"
        },
        "$push": {
            "quotes": {
                "quote_no": 2002,
                "quote_prepared_on": "02-Jun-2026",
                "preferred_start_date": "10-Jun-2026",
                "start_location": "Adelaide SA 5000",
                "end_location": "Melbourne VIC 3000",
                "quote_cost": "$3200.00",
                "assigned_to_job": "Y",
                "job_cost": "$3200.00"
            }
        }
    }
);

// Show the customer details after adding quote
db.brm_customers.find({"_id": {"$eq": 1001}});








// End of file - do not remove
