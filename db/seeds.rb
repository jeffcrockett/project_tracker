# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

def prodID(n)
  Product.find_by(name:n).id
end

def distID(n)
  Distributor.find_by(name:n).id
end

def compID(n)
  Company.find_by(name:n).id
end

def projID(c, n)
  cid = compID(c)
  Project.find_by(company_id:cid, name:n).id
end


Shipment.destroy_all
Registration.destroy_all
Project.destroy_all
Distributor.destroy_all
Product.destroy_all
Company.destroy_all
User.destroy_all

User.create!([
{
  name:"both",
  password:"both",
  admin:"true",
  exec:"true"
},
{
  name:"adminOnly",
  password:"adminOnly",
  admin:"true",
  exec:"false"
},
{
  name:"execOnly",
  password:"execOnly",
  admin:"false",
  exec:"true"
},
{
  name:"neither",
  password:"neither",
  admin:"false",
  exec:"false"
}])

Company.create!([
{
  name:"Unknown"
},
{
  name:"Company1"
},
{
  name:"Company2"
},
{
  name:"Company3"
}])

Product.create!([
{
  name:"PTA PRO 1S",
  price:104.00,
  cogs:30.42
},
{
  name:"PTA PRO 2S 1LTE !WIFI",
  price:129.00,
  cogs:37.73
},
{
  name:"PTA PRO 3S LTEWIFIGPS",
  price:144.00,
  cogs:42.12
},
{
  name:"PTA PRO 1ST",
  price:104.00,
  cogs:30.42
},
{
  name:"PTA PRO 2ST",
  price:134.00,
  cogs:39.20
},
{
  name:"PTA PRO 3ST",
  price:149.00,
  cogs:43.58
},
{
  name:"PTA PRO 4ST",
  price:174.00,
  cogs:50.90
},
{
  name:"PTA PRO 5ST",
  price:209.00,
  cogs:61.13
},
{
  name:"PTA PRO 6ST",
  price:219.00,
  cogs:64.06
},
{
  name:"PTA PRO 2C",
  price:209.00,
  cogs:61.13
},
{
  name:"PTA PRO 3C",
  price:219.00,
  cogs:64.06
},
{
  name:"PTA PRO 4C",
  price:229.00,
  cogs:66.98
},
{
  name:"PTA PRO 4C - Double MIMO",
  price:329.00,
  cogs:96.23
},
{
  name:"PTA PRO 5C",
  price:249.00,
  cogs:72.83
},
{
  name:"PTA PRO 5C - Double MIMO/GPS",
  price:329.00,
  cogs:96.23
},
{
  name:"PTA PRO 2R",
  price:209.00,
  cogs:61.13
},
{
  name:"PTA PRO 3R",
  price:239.00,
  cogs:69.91
},
{
  name:"PTA PRO 4R",
  price:249.00,
  cogs:72.83
},
{
  name:"PTA PRO 5R",
  price:259.00,
  cogs:75.76
},
{
  name:"PTA PRO 6R",
  price:269.00,
  cogs:78.68
},
{
  name:"PTA PRO 2D",
  price:295.00,
  cogs:86.29
},
{
  name:"PTA PRO 3D",
  price:305.00,
  cogs:89.21
},
{
  name:"PTA PRO 4D",
  price:315.00,
  cogs:92.14
},
{
  name:"PTA PRO 5D",
  price:325.00,
  cogs:95.06
},
{
  name:"PTA PRO 6D",
  price:335.00,
  cogs:97.99
},
{
  name:"PTA PRO 2GS",
  price:279.00,
  cogs:81.61
},
{
  name:"PTA PRO 3GS",
  price:299.00,
  cogs:87.46
},
{
  name:"PTA PRO 4GS",
  price:319.00,
  cogs:93.31
},
{
  name:"PTA PRO 5GS",
  price:339.00,
  cogs:99.16
},
{
  name:"PTA PRO 7H - 2LTE/4WIFI/GPS",
  price:409.00,
  cogs:119.63
},
{
  name:"PTA PRO 7H",
  price:445.00,
  cogs:130.16
},
{
  name:"PTA PRO 9H",
  price:509.00,
  cogs:148.88
},
{
  name:"PTA PRO 11H",
  price:549.00,
  cogs:160.58
},
{
  name:"Labrador W/1ft Conn.",
  price:129.00,
  cogs:37.73
},
{
  name:"Labrador W/15ft",
  price:149.00,
  cogs:43.58
},
{
  name:"Great Dane",
  price:329.00,
  cogs:96.23
},
{
  name:"Great Dane W Cables",
  price:399.00,
  cogs:116.71
},
{
  name:"Blade",
  price:69.00,
  cogs:20.18
},
{
  name:"MM MIMO",
  price:49.00,
  cogs:14.33
}])


Distributor.create!([
{
  name:"Parsec",
  discount:0
},
{
  name:"CSG",
  discount:45
},
{
  name:"INS",
  discount:45
},
{
  name:"Dist1",
  discount:25
},
{
  name:"Dist2",
  discount:25
}])


Project.create!([
{
  company_id:compID("Unknown"),
  name:"CSG Restock",
  confidence:100,
  distributor_id:distID("CSG"),
  rep:"Joe Repp",
  application:"Unknown"
},
{
  company_id:compID("Unknown"),
  name:"INS Restock",
  confidence:100,
  distributor_id:distID("INS"),
  rep:"Jane Repp",
  application:"Unknown"
},
{
  company_id:compID("Company1"),
  name:"Project1 Trial",
  confidence:100,
  distributor_id:distID("Parsec"),
  rep:"Joe Repp",
  application:"Whatever"
},
{
  company_id:compID("Company1"),
  name:"Project1 Deployment",
  confidence:80,
  distributor_id:distID("Parsec"),
  rep:"Jane Repp",
  application:"Whatever"
},
{
  company_id:compID("Company2"),
  name:"Project1",
  confidence:90,
  distributor_id:distID("Parsec"),
  rep:"Joe Repp",
  application:"Whatever"
},
{
  company_id:compID("Company3"),
  name:"Project1",
  confidence:50,
  distributor_id:distID("CSG"),
  rep:"Jane Repp",
  application:"Whatever"
}])


Shipment.create!([
{
  project_id:projID("Unknown","CSG Restock"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"01/01/2019"
},
{
  project_id:projID("Unknown","CSG Restock"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"01/01/2019"
},
{
  project_id:projID("Unknown","CSG Restock"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"02/01/2019"
},
{
  project_id:projID("Unknown","CSG Restock"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"02/01/2019"
},
{
  project_id:projID("Unknown","INS Restock"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"01/02/2019"
},
{
  project_id:projID("Unknown","INS Restock"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"01/02/2019"
},
{
  project_id:projID("Unknown","INS Restock"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"02/02/2019"
},
{
  project_id:projID("Unknown","INS Restock"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"02/02/2019"
},
{
  project_id:projID("Company1","Project1 Trial"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"01/03/2019"
},
{
  project_id:projID("Company1","Project1 Trial"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"01/03/2019"
},
{
  project_id:projID("Company1","Project1 Trial"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"02/03/2019"
},
{
  project_id:projID("Company1","Project1 Trial"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"02/03/2019"
},
{
  project_id:projID("Company1","Project1 Deployment"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"01/04/2019"
},
{
  project_id:projID("Company1","Project1 Deployment"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"01/04/2019"
},
{
  project_id:projID("Company1","Project1 Deployment"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"02/04/2019"
},
{
  project_id:projID("Company1","Project1 Deployment"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"02/04/2019"
},
{
  project_id:projID("Company2","Project1"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"01/05/2019"
},
{
  project_id:projID("Company2","Project1"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"01/05/2019"
},
{
  project_id:projID("Company2","Project1"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"02/05/2019"
},
{
  project_id:projID("Company2","Project1"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"02/05/2019"
},
{
  project_id:projID("Company3","Project1"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"01/06/2019"
},
{
  project_id:projID("Company3","Project1"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"01/06/2019"
},
{
  project_id:projID("Company3","Project1"),
  product_id:prodID("Great Dane"),
  quantity:100,
  date:"02/06/2019"
},
{
  project_id:projID("Company3","Project1"),
  product_id:prodID("PTA PRO 1S"),
  quantity:100,
  date:"02/06/2019"
}])


Registration.create!([
{
  project_id:projID("Company3","Project1"),
  contact:"CSG Contact 1",
  expiration:"03/31/19"
}])