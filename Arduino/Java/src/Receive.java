import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.Socket;


public class Receive implements Runnable {
	Socket socket;
	BufferedReader recieve=null;
	
	/*Metódo*/
	public Receive(Socket socket){
		this.socket = socket;
	}
	
	public void run() {
		try{
			/*recebe a mensagem do canal de entrada*/
			recieve = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
			String msgRecieved = null;
		/*Enquanto tiver mensagem para ler, imprime a mensagem*/
		while((msgRecieved = recieve.readLine())!= null){
			System.out.println(msgRecieved);
		}
		}catch(Exception e){System.out.println(e.getMessage());}
	}
}

