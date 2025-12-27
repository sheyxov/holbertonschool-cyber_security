#!/bin/bash
whois $1 | awk 'BEGIN{OFS=","}
$1=="Registrant"&&$2=="Name:"{print "Registrant Name",substr($0,index($0,$3))}
$1=="Registrant"&&$2=="Organization:"{print "Registrant Organization",substr($0,index($0,$3))}
$1=="Registrant"&&$2=="Street:"{print "Registrant Street",substr($0,index($0,$3))" "}
$1=="Registrant"&&$2=="City:"{print "Registrant City",substr($0,index($0,$3))}
$1=="Registrant"&&$2=="State/Province:"{print "Registrant State/Province",substr($0,index($0,$3))}
$1=="Registrant"&&$2=="Postal"{print "Registrant Postal Code",substr($0,index($0,$4))}
$1=="Registrant"&&$2=="Country:"{print "Registrant Country",substr($0,index($0,$3))}
$1=="Registrant"&&$2=="Phone:"{print "Registrant Phone",substr($0,index($0,$3))}
$1=="Registrant"&&$2=="Phone"&&$3=="Ext:"{print "Registrant Phone Ext:",""}
$1=="Registrant"&&$2=="Fax:"{print "Registrant Fax",""}
$1=="Registrant"&&$2=="Fax"&&$3=="Ext:"{print "Registrant Fax Ext:",""}
$1=="Registrant"&&$2=="Email:"{print "Registrant Email",substr($0,index($0,$3))}
$1=="Admin"&&$2=="Name:"{print "Admin Name",substr($0,index($0,$3))}
$1=="Admin"&&$2=="Organization:"{print "Admin Organization",substr($0,index($0,$3))}
$1=="Admin"&&$2=="Street:"{print "Admin Street",substr($0,index($0,$3))" "}
$1=="Admin"&&$2=="City:"{print "Admin City",substr($0,index($0,$3))}
$1=="Admin"&&$2=="State/Province:"{print "Admin State/Province",substr($0,index($0,$3))}
$1=="Admin"&&$2=="Postal"{print "Admin Postal Code",substr($0,index($0,$4))}
$1=="Admin"&&$2=="Country:"{print "Admin Country",substr($0,index($0,$3))}
$1=="Admin"&&$2=="Phone:"{print "Admin Phone",substr($0,index($0,$3))}
$1=="Admin"&&$2=="Phone"&&$3=="Ext:"{print "Admin Phone Ext:",""}
$1=="Admin"&&$2=="Fax:"{print "Admin Fax",""}
$1=="Admin"&&$2=="Fax"&&$3=="Ext:"{print "Admin Fax Ext:",""}
$1=="Admin"&&$2=="Email:"{print "Admin Email",substr($0,index($0,$3))}
$1=="Tech"&&$2=="Name:"{print "Tech Name",substr($0,index($0,$3))}
$1=="Tech"&&$2=="Organization:"{print "Tech Organization",substr($0,index($0,$3))}
$1=="Tech"&&$2=="Street:"{print "Tech Street",substr($0,index($0,$3))" "}
$1=="Tech"&&$2=="City:"{print "Tech City",substr($0,index($0,$3))}
$1=="Tech"&&$2=="State/Province:"{print "Tech State/Province",substr($0,index($0,$3))}
$1=="Tech"&&$2=="Postal"{print "Tech Postal Code",substr($0,index($0,$4))}
$1=="Tech"&&$2=="Country:"{print "Tech Country",substr($0,index($0,$3))}
$1=="Tech"&&$2=="Phone:"{print "Tech Phone",substr($0,index($0,$3))}
$1=="Tech"&&$2=="Phone"&&$3=="Ext:"{print "Tech Phone Ext:",""}
$1=="Tech"&&$2=="Fax:"{print "Tech Fax",""}
$1=="Tech"&&$2=="Fax"&&$3=="Ext:"{print "Tech Fax Ext:",""}
$1=="Tech"&&$2=="Email:"{print "Tech Email",substr($0,index($0,$3))}' > $1.csv
