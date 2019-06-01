
import Foundation

let domain = "https://app-car.carsalesnetwork.com.au"
let route = "/stock/car/test/v1/listing/"
let param = "?username=test&password=2h7H53eXsQupXvkz"
var DetailsUrl = route;

//main data
struct tdata : Codable {
    let Id: String
    let Title: String
    let Location: String
    let Price: String
    let MainPhoto: String
    let DetailsUrl: String
}
struct thedata: Codable{
    let Result: [tdata]
}
var Tdata: [tdata] = []; // original array for all states
var Tfilter : [tdata] = []; // to filter to display date on state based on filter
//detail data
struct overview: Codable {
    let Location: String
    let Price: String
    let Photos: [String]
}
struct detailData: Codable {
    let Id: String
    let SaleStatus: String
    let Overview: overview
    let Comments: String
}
struct thedetail: Codable {
    let Result: [detailData];
}

