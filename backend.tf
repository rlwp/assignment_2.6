terraform {
 backend "s3" {
   bucket = "sctp-ce9-tfstate"
   key    = "rudylee_ce9.tfstate" # Replace the value of key to <your suggested name>.tfstat   
   region = "us-east-1"
 }
}
