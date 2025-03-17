package com.console;
import java.util.*;
import com.dao.*;
import com.model.*;

public class Console {

	public static Admin loggedAdmin = null;
	public static Customer loggedCustomer = null;
	
	public static void main(String []args) {
		Scanner sc = new Scanner(System.in);
		
		int choise = 1;
		while(choise != 0) {
			System.out.println("\n");
			System.out.println("########################################");
			System.out.println("#                                      #");
			System.out.println("#    Train Ticket Management System    #");
			System.out.println("#                                      #");
			System.out.println("########################################");
			System.out.println("#                                      #");
			System.out.println("#  1 --> Admin Operations              #");
			System.out.println("#  2 --> Customer Operations           #");
			System.out.println("#  0 --> Exit                          #");
			System.out.println("#                                      #");
			System.out.println("########################################");
			TrainDAO trainDao = new TrainDAO();
			AdminDAO adminDao = new AdminDAO();
			StationDAO stationDao = new StationDAO();
			
			System.out.println("\nEnter your choise : ");
			choise = Integer.parseInt(sc.nextLine());
			switch(choise) {
				case 1:
					String name, password, email, phone;
					String tName, from, to;
					int seats, fare;
					while(choise != 11) {
						System.out.println("\n");
						System.out.println("########################################");
						System.out.println("#                                      #");
						System.out.println("#            Admin Dashboard           #");
						System.out.println("#                                      #");
						System.out.println("########################################");
						System.out.println("#                                      #");
						System.out.println("#  1 --> Registration                  #");
						System.out.println("#  2 --> Login                         #");
//						System.out.println("#  3 --> View All Admins               #");
						System.out.println("#  3 --> Add Station                   #");
						System.out.println("#  4 --> View All Stations             #");
						System.out.println("#  5 --> Delete Station                #");
						System.out.println("#  6 --> Add Train                     #");
						System.out.println("#  7 --> View All Trains               #");
						System.out.println("#  8 --> Delete Train                  #");
						System.out.println("#  9 --> View Profile                  #");
						System.out.println("#  10 --> Log Out                       #");
						System.out.println("#  11 --> Exit                          #");
						System.out.println("#                                      #");
						System.out.println("########################################");
						System.out.println("\nEnter your choise : ");
						choise = Integer.parseInt(sc.nextLine());
						switch(choise) {
							case 1:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Admin Registraion           #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								
								System.out.println("Enter Admin Name : ");
								name = sc.nextLine();
								System.out.println("Enter Addmin Email : ");
								email = sc.nextLine();
								System.out.println("Enter Admin Phone Number : ");
								phone = sc.nextLine();
								System.out.println("Enter Admin Password : ");
								password = sc.nextLine();
								
								Admin admin = new Admin();
								admin.setName(name);
								admin.setUname(name);
								admin.setEmail(email);
								admin.setPhoneNo(phone);
								admin.setPassword(password);
								if(adminDao.registerAdmin(admin))
									System.out.println("Admin Registered Succeessfully.");
								else
									System.out.println("Error Encountered while Registerig Admin.");
								break;
							case 2:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Admin Login                 #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								System.out.println("\nEnter UserName : ");
								name = sc.nextLine();
								System.out.println("Enter Password : ");
								password = sc.nextLine();
								 loggedAdmin = adminDao.loginAdmin(name, password);
								 if(loggedAdmin != null)
									 System.out.println("Admin : "+loggedAdmin.getUname()+" logged in successfully.");
								 else
									 System.out.println("Error Encounterd while logging.");
								break;
							case 3:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Add Station                 #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								System.out.println("\nEnter Station Name : ");
								String stationName = sc.nextLine();
								if(loggedAdmin == null)
									System.out.println("Admin is not logged in !! first Login to your account.");
								 else {
									 Station station = new Station();
									 station.setStationName(stationName);
									 stationDao.addStation(station);
									 System.out.println("Station added.");
								 }
								break;	
							case 4:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          All Stations                #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedAdmin == null)
									System.out.println("Admin is not logged in !! first Login to your account.");
								 else {
									 ArrayList<Station> stations = new ArrayList<>(stationDao.getAllStations());
									 if(stations.size()==0)
										 System.out.println("No Stations Found !!");
									 else {
										 for(Station s : stations) {
											 System.out.println(s.getStationId()+" "+s.getStationName());
										 }
									 }
								 }
								break;
							case 5:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Delete Station              #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedAdmin == null)
									System.out.println("Admin is not logged in !! first Login to your account.");
								else {
									System.out.println("Enter station Id : ");
									int sId = Integer.parseInt(sc.nextLine());
									stationDao.deleteStationById(sId);
									System.out.println("Station Deleted.");
								}
								break;
							case 6: 
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Add Train                   #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedAdmin == null)
									System.out.println("Admin is not logged in !! first Login to your account.");
								else {
									System.out.println("Enter Train Name : ");
									tName = sc.nextLine();
									System.out.println("From Station : ");
									from = sc.nextLine();
									System.out.println("To Station : ");
									to =sc.nextLine();
									System.out.println("Enter Available Seats : ");
									seats = Integer.parseInt(sc.nextLine());
									System.out.println("Enter Train Fare : ");
									fare = Integer.parseInt(sc.nextLine());
									Train train = new Train();
									train.setTrainName(tName);
									train.setFromStation(from);
									train.setToStation(to);
									train.setAvailableSeats(seats);
									train.setFare(fare);
									trainDao.addTrain(train);
									System.out.println("Train added successfully.");
								}
								break;
							case 7:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          View All Trains             #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedAdmin == null)
									System.out.println("Admin is not logged in !! first Login to your account.");
								else {
									 ArrayList<Train> trains = new ArrayList<>(trainDao.getAllTrains());
									 if(trains.size()==0)
										 System.out.println("No Trains Found !!");
									 else {
										 for(Train t : trains) {
											 System.out.println(t.getTrainNo()+" "+t.getTrainName()+" "+t.getFromStation()+" "+t.getToStation()+" "+t.getAvailableSeats()+" "+t.getFare());
										 }
									 }
								}
								break;
							case 8:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Delete Train                #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedAdmin == null)
									System.out.println("Admin is not logged in !! first Login to your account.");
								else {
									System.out.println("Enter Train Id : ");
									int tId = Integer.parseInt(sc.nextLine());
									trainDao.deleteTrain(tId);
									System.out.println("Train Deleted.");
								}
								break;
							case 9:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Admin Profile               #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedAdmin == null)
									System.out.println("Admin is not logged in !! first Login to your account.");
								else
								{
									System.out.println("Id  : "+loggedAdmin.getAdminId());
									System.out.println("User Name : "+loggedAdmin.getUname());
									System.out.println("Email : "+loggedAdmin.getEmail());
									System.out.println("Phone No : "+loggedAdmin.getPhoneNo());
								}
								break;	
							case 10:
								if(loggedAdmin == null)
									System.out.println("\n Admin is not logged In.");
								else {
									loggedAdmin = null;
									System.out.println("\n      Admin Logged Out .....");
									System.out.println("############################################");	
								}
							default:
								break;
						}
					}
					break;
				case 2:
					String cname, cemail, cpassword, address, cphone, adhar, active;
					while(choise != 9) {
						System.out.println("\n");
						System.out.println("########################################");
						System.out.println("#                                      #");
						System.out.println("#            Customer Dashboard        #");
						System.out.println("#                                      #");
						System.out.println("########################################");
						System.out.println("#                                      #");
						System.out.println("#  1 --> Registration                  #");
						System.out.println("#  2 --> Login                         #");
						System.out.println("#  3 --> View All Trains               #");
						System.out.println("#  4 --> Book Ticket                   #");
						System.out.println("#  5 --> View All Tickets              #");
						System.out.println("#  6 --> Cancel Ticket                 #");
						System.out.println("#  7 --> View Profile                  #");
						System.out.println("#  8 --> Log Out                       #");
						System.out.println("#  9 --> Exit                          #");
						System.out.println("#                                      #");
						System.out.println("########################################");
						
						CustomerDAO customerDao = new CustomerDAO();
						System.out.println("\nEnter your choise : ");
						choise = Integer.parseInt(sc.nextLine());
						TicketDAO ticketDao = new TicketDAO();
						
						switch(choise) {
							case 1:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Customer Registraion        #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								System.out.println("Enter UserName : ");
								cname = sc.nextLine();;
								System.out.println("Enter Email : ");
								cemail = sc.nextLine();
								System.out.println("Enter Phone No : ");
								cphone = sc.nextLine();
								System.out.println("Enter Aadhar No  : ");
								adhar = sc.nextLine();
								System.out.println("Enter Address : ");
								address = sc.nextLine();
								System.out.println("Enter Password : ");
								cpassword = sc.nextLine();
								
								Customer customer = new Customer();
								customer.setUserName(cname);
								customer.setEmail(cemail);
								customer.setContactNumber(cphone);
								customer.setAadharNumber(adhar);
								customer.setAddress(address);
								customer.setPassword(cpassword);
								if(customerDao.registerCustomer(customer))
									System.out.println("Customer added successfully.");
								else
									System.out.println("Error Encounterd while regidtering Customer.");
								break;
							case 2:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Customer Login              #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								System.out.println("Enter UserName : ");
								cname = sc.nextLine();
								System.out.println("Enter Password : ");
								cpassword = sc.nextLine();
								loggedCustomer = customerDao.loginCustomer(cname, cpassword);
								if(loggedCustomer == null)
									System.out.println("Error Encountered while logging Customer.");
								else
									System.out.println("Customer : "+loggedCustomer.getUserName()+" logged in successfully.");								
								break;
								
							case 3:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          All Trains                  #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedCustomer == null)
									System.out.println("Customer is not logged in !! first Login to your account.");
								else {
									 ArrayList<Train> trains = new ArrayList<>(trainDao.getAllTrains());
									 if(trains.size()==0)
										 System.out.println("No Trains Found !!");
									 else {
										 for(Train t : trains) {
											 System.out.println(t.getTrainNo()+" "+t.getTrainName()+" "+t.getFromStation()+" "+t.getToStation()+" "+t.getAvailableSeats()+" "+t.getFare());
										 }
									 }
								}
								break;
							case 4:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#         Book Ticket                  #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedCustomer == null) 							
									System.out.println("Customer is not logged in !! first Login to your account.");
								else {
									String pnr = "PNR" + (int) (Math.random() * 1000000);
									System.out.println("Enter Train Id : ");
									int bid = Integer.parseInt(sc.nextLine());
									System.out.println("Enter Train Number : ");
									int btId = Integer.parseInt(sc.nextLine());
									System.out.println("Enter Train Name : ");
									String btName = sc.nextLine();
									System.out.println("Enter Boarding Station : ");
									String bFrom = sc.nextLine();
									System.out.println("Enter Destination Station : ");
									String bTo = sc.nextLine();
									System.out.println("Enter Seats : ");
									int nSeats = Integer.parseInt(sc.nextLine());
									System.out.println("Enter Seats : ");
									int bfare = Integer.parseInt(sc.nextLine());
									
									Ticket ticket = new Ticket();
									ticket.setPnr(pnr);
									ticket.setTrainNumber(btId);
									ticket.setTrainName(btName);
									ticket.setFromStation(bFrom);
									ticket.setToStation(bTo);
									ticket.setSeatCount(nSeats);
									ticket.setTotalFare(bfare);
									ticket.setUserId(loggedCustomer.getUserId());
									if(ticketDao.bookTicket(ticket))
										System.out.println("Ticket added successfully.");
									else
										System.out.println("Error Encounterd while adding ticket.");	
								}								
								break;
							case 5:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          All Tickets                 #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedCustomer == null) 							
									System.out.println("Customer is not logged in !! first Login to your account.");
								else {
									ArrayList<Ticket> tickets = new ArrayList(ticketDao.getTicketsByUserId(loggedCustomer.getUserId()));
									if(tickets.size() == 0)
										System.out.println("No Tickets Found.");
									else {
										for(Ticket t : tickets) {
											System.out.println(t.getPnr()+" "+t.getFromStation()+" "+t.getToStation()+" "+t.getSeatCount()+" "+t.getTotalFare());
										}
									}	
								}
								break;
							case 6:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Cancel Ticket               #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedCustomer == null) 							
									System.out.println("Customer is not logged in !! first Login to your account.");
								else {
									System.out.println("Enter PNR : ");								
									String cpnr = sc.nextLine();
									if(ticketDao.cancelTicket(cpnr))
										System.out.println("TIcket Cancelled.");
									else
										System.out.println("Error Encountered while cancelling Ticket.");				
								}
								break;
							case 7:
								System.out.println("########################################");
								System.out.println("#                                      #");
								System.out.println("#          Profile                     #");
								System.out.println("#                                      #");
								System.out.println("########################################");
								if(loggedCustomer == null)
									System.out.println("Customer is not logged in !! first Login to your account.");
								else {
									System.out.println("User ID : "+loggedCustomer.getUserId());
									System.out.println("User Name : "+loggedCustomer.getUserName());
									System.out.println("Email : "+loggedCustomer.getEmail());
									System.out.println("Adhar : "+loggedCustomer.getAadharNumber());
									System.out.println("Mobile : "+loggedCustomer.getContactNumber());
									System.out.println("Address : "+loggedCustomer.getAddress());
								}
								break;
							case 8:
								if(loggedCustomer == null)
									System.out.println("\n Customer is not logged In.");
								else {
									loggedCustomer = null;
									System.out.println("\n      Customer Logged Out .....");
									System.out.println("############################################");	
								}
							default:
								break;
						}
					}
					break;
				default :
//					System.out.println("---------- Wrong Choise ----------");
					break;
			}	
		}
		
		System.out.println("########################################");
		System.out.println("#                                      #");
		System.out.println("#                THE END               #");
		System.out.println("#                                      #");
		System.out.println("########################################");
		
	}
}
