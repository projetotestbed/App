import java.net.Socket;

public class Client {
	public static void main(String[] args){
		/*Endereço ip do portal*/
		String IP = "146.164.247.210";
		int port = 0;
		
		if(args.length != 1){
			System.out.println("Faltando argumento: <porta>");
			System.exit(1);
		}
		try{
			port = Integer.parseInt(args[0]);
		}catch(NumberFormatException e){
			System.out.println("Argumento deve ser um número inteiro");
			
		}
		try {
			Socket socket= new Socket(IP,port);
			Receive rec= new Receive(socket);
			Thread thread =new Thread(rec);thread.start();
		} catch (Exception e) {System.out.println(e.getMessage());} 
	}
}
