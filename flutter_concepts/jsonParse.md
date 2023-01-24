# Parsing JSON in Flutter

---
For the json parsing, let's use "dart:convert" library
- "dart:convert" library is used for the small projects.
- "json_serializable library is used for the larger projects.

## 1. Json Structure
Let's begin with JSON style employer.json which has Map type.

    {
      "id":"13234",
      "name":"Humpty",
      "department":"Engineering"
    }

1. JSON has the structure of Map(key-value pair), or List of Maps
2. If Json file starts with curlyl braces{} for the Map, while it starts with Square bracket [] for the List of Map

Lets' convert given Json into PODO(Plain Old Dart Objcet)

    class Employer{
       String employerId;
       String employerName;
       String employerDep;
    Employer({
       this.employerId,
       this.employerName,
       this.employerDep
     });
    }
    
By creating a **factory method**, we can do the work of mapping these class members to the json object.

    what is Factory?
    - factory keyword is used when implementing a constructor that doesn't always create 
    a new instance of its class
    
    
    factory Employer.fromEmployer(Map<String, dynamic> parsedEmployer){
        return Employer(
            employerId: parsedEmployer['id'],
            employerName: parsedEmployer['name'],
            employerScores: parsedEmployer['department']
        );
    }
    
    ==> Employer.fromEmployer method whose objective is to deserialize json.
    
##### Deserialization vs Serialization
- Serialization : converting data -> string
- Deserialization : converting string -> data

---
## Accessing the object

Step 1. imports
Step 2. load Json Asset

    Future<String> _loadAEmployerAsset() aysnc {
      return await rootBundle.loadString('assets/employer.json');
    }
    
Step 3. load the response

    Future loadEmployer() async {
      String jsonString = await _loadAEmployerAsset(); //loading the raw json String
      final jsonResponse = json.decode(jsonString); //Decoding raw json String
      Employer employer = Employer.fromEmployer(jsonResponse); //deserialize(string -> data) the decoded json response
    }
  
