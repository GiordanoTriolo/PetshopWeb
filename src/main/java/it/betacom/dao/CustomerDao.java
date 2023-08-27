package it.betacom.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;

import it.betacom.bean.Customer;
import it.betacom.connection.DBHandler;

public class CustomerDao {
	public static DBHandler db = DBHandler.getInstance();
	
	private static final Logger logger = (Logger) LogManager.getLogger(CustomerDao.class);
	

	public static int save(Customer c) {
	    int status=0;
	    String sql = "INSERT INTO customers (nome,cognome,cellulare,passwd,data_di_nascita,username, citta, indirizzo) VALUES(?,?,?,?,?,?,?,?)";
	    try {
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ps.setString(1, c.getNome());
	        ps.setString(2, c.getCognome());
	        ps.setString(3, c.getCellulare());
	        ps.setString(4, c.getPassword());
	        ps.setString(5, c.getData_di_nascita());
	        ps.setString(7, c.getCitta());
	        ps.setString(8, c.getIndirizzo());
	        String username = c.getNome().substring(0, 2).toUpperCase() + c.getCognome().substring(0, 2).toUpperCase() + c.getData_di_nascita().substring(0, 4);
	        c.setUsername(username);//LOGGER
	        int i = 1;
	        while(getRecordByUsername(username)!=null) {
	            if (username.equals(getRecordByUsername(username).getUsername())) {
	                if (i==1) {
	                    username = username + "_";
	                }
	                int indice = username.lastIndexOf("_");
	                username = username.substring(0, indice + 1);
	                username = username  + i;
	                i++;
	                c.setUsername(username);
	            } else break;
	    }
	        ps.setString(6, c.getUsername());
	        status=ps.executeUpdate();
	        logger.info("Registrazione effettuata per il cliente " + c.getUsername());

	        int generatedId = getLastInsertedId();

	        c.setId(generatedId);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return status;
	}
	
	private static int getLastInsertedId() {
	    int lastInsertedId = 0;
	    try {
	        String sql = "SELECT MAX(id_customer) FROM customers"; 
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            lastInsertedId = rs.getInt(1);
	        }
	        rs.close();
	        ps.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return lastInsertedId;
	}

	public static List<Customer> getAllRecords() {
		List<Customer> list = new ArrayList<Customer>();
		String sql = "Select * from customers c";
		try {
			PreparedStatement ps = db.getConnection().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Customer c = new Customer();
				c.setNome(rs.getString("nome"));
				c.setCognome(rs.getString("cognome"));
				c.setCellulare(rs.getString("cellulare"));
				c.setData_di_nascita(rs.getString("data_di_nascita"));
				c.setPassword(rs.getString("passwd"));
				c.setUsername(rs.getString("username"));
				c.setCitta(rs.getString("citta"));
				c.setIndirizzo(rs.getString("indirizzo"));
				list.add(c);		
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static Customer getRecordByUsername(String username) {
		System.out.println(username);
		Customer c = null;
		String sql = "select * from customers where username=?";
		try {
			PreparedStatement ps = db.getConnection().prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				c = new Customer();
				c.setNome(rs.getString("nome"));
				c.setCognome(rs.getString("cognome"));
				c.setCellulare(rs.getString("cellulare"));
				c.setData_di_nascita(rs.getString("data_di_nascita"));
				c.setPassword(rs.getString("passwd"));
				c.setUsername(rs.getString("username"));
				c.setCitta(rs.getString("citta"));
				c.setIndirizzo(rs.getString("indirizzo"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return c;
	}
	
	public static int getIdByUsername(String username) {
	    int id = -1; 

	    String sql = "SELECT id_customer FROM customers WHERE username = ?";
	    try {
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ps.setString(1, username);
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            id = rs.getInt("id_customer");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return id;
	}

	public static int update(Customer c) {
	    int status = 0;
	    String sql = "update customers set nome=?, cognome=?, cellulare=?, data_di_nascita=?, passwd=?, citta=?, indirizzo=? where username=?";
	    try {
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ps.setString(1, c.getNome());
	        ps.setString(2, c.getCognome());
	        ps.setString(3, c.getCellulare());
	        ps.setString(4, c.getData_di_nascita());
	        ps.setString(5, c.getPassword());
	        ps.setString(6, c.getCitta());
	        ps.setString(7, c.getIndirizzo());
	        ps.setString(8, c.getUsername());
	        ps.executeUpdate();

	        // Qui aggiorniamo lo username separatamente
	        String newUsername = c.getNome().substring(0, 2).toUpperCase() + c.getCognome().substring(0, 2).toUpperCase() + c.getData_di_nascita().substring(0, 4);
	        PreparedStatement ps1 = db.getConnection().prepareStatement("update customers set username = ? where username = ?");
	        int i = 1;
	        while(getRecordByUsername(newUsername)!=null) {
	            if (newUsername.equals(getRecordByUsername(newUsername).getUsername())) {
	                if (i==1) {
	                	newUsername = newUsername + "_";
	                }
	                int indice = newUsername.lastIndexOf("_");
	                newUsername = newUsername.substring(0, indice + 1);
	                newUsername = newUsername + i;
	                i++;
	                System.out.println(newUsername);
	                c.setUsername(newUsername);
	            } else break;
	    }
	        ps1.setString(1, newUsername);
	        ps1.setString(2, c.getUsername());
	        status = ps1.executeUpdate();
	        
	        logger.info("Update effettuato per il cliente " + c.getUsername());
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return status;
	}
	
	

	public static int delete(Customer c) {
		int status = 0;
		System.out.println(c.toString());
		try {
			PreparedStatement ps = db.getConnection().prepareStatement("delete from customers where username=?");
			ps.setString(1, c.getUsername());
			status = ps.executeUpdate();
			logger.info("Eliminazione cliente " + c.getUsername() + " effettuata");
		} catch (Exception e) {
			System.out.println(e);
		}

		return status;
	}
	
	

	public static boolean login(Customer c) {
        boolean accessoEffettuato = false;
        try {
            PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM customers WHERE username=? AND passwd=?");
            ps.setString(1, c.getUsername());
            ps.setString(2, c.getPassword());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");
                if ("A".equals(status)) {
                    accessoEffettuato = true;
                    
                    int customerId = rs.getInt("id_customer");
                    c.setId(customerId);
                }
            }
            logger.info("Login effettuato per il cliente " + c.getUsername());
        } catch (Exception e) {
            System.out.println(e);
        }
        return accessoEffettuato;
    }
	
	
	public static int updateStatusEnabled(Customer c) {
        int status = 0;
        try {
            PreparedStatement ps = db.getConnection().prepareStatement("update customers set status = ? where username = ?");
            ps.setString(1, "A");
            ps.setString(2, c.getUsername());
            c.setStatus("A");
            status=ps.executeUpdate();
            logger.info("Abilitazione effettuata per il cliente " + c.getUsername());
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static int updateStatusDisabled(Customer c) {
        int status = 0;
        try {
            PreparedStatement ps = db.getConnection().prepareStatement("update customers set status = ? where username = ?");
            ps.setString(1, "D");
            ps.setString(2, c.getUsername());
            c.setStatus("D");
            status=ps.executeUpdate();
            logger.info("Disabilitato il cliente " + c.getUsername());
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}