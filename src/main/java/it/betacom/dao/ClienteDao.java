package it.betacom.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import it.betacom.bean.Cliente;
import it.betacom.connection.DBHandler;

public class ClienteDao {
	public static DBHandler db = DBHandler.getInstance();
	
	private static final Logger logger = LogManager.getLogger(ClienteDao.class);
	

	public static int save(Cliente c) {
	    int status=0;
	    String sql = "INSERT INTO cliente (nome,cognome,email,cellulare,passwd,data_di_nascita,username,ruolo,status) VALUES(?,?,?,?,?,?,?,?,?)";
	    try {
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ps.setString(1, c.getNome());
	        ps.setString(2, c.getCognome());
	        ps.setString(3, c.getEmail());
	        ps.setString(4, c.getCellulare());
	        ps.setString(5, c.getPassword());
	        ps.setString(6, c.getData_di_nascita());
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
	        ps.setString(7, c.getUsername());
	        
	        String find = "SELECT 1 FROM cliente LIMIT 1";
	        Statement s = db.getConnection().createStatement();
	        ResultSet rs = s.executeQuery(find);
	        if (rs.next()) {
	        	c.setRuolo("G");
            } else {
	        	c.setRuolo("M"); 
            }      
	        ps.setString(8, c.getRuolo());
	        
	        c.setStatus("A");
	        ps.setString(9, c.getStatus());
	        status=ps.executeUpdate();
	        logger.info("Registrazione effettuata per l’utente " + c.getUsername());
   
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return status;
	}

	public static List<Cliente> getAllRecords() {
		List<Cliente> list = new ArrayList<Cliente>();
		String sql = "Select * from cliente c";
		try {
			PreparedStatement ps = db.getConnection().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Cliente c = new Cliente();
				c.setNome(rs.getString("nome"));
				c.setCognome(rs.getString("cognome"));
				c.setEmail(rs.getString("email"));
				c.setCellulare(rs.getString("cellulare"));
				c.setData_di_nascita(rs.getString("data_di_nascita"));
				c.setPassword(rs.getString("passwd"));
				c.setUsername(rs.getString("username"));
				list.add(c);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static Cliente getRecordByUsername(String username) {
		System.out.println(username);
		Cliente c = null;
		String sql = "select * from cliente where username=?";
		try {
			PreparedStatement ps = db.getConnection().prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				c = new Cliente();
				c.setNome(rs.getString("nome"));
				c.setCognome(rs.getString("cognome"));
				c.setEmail(rs.getString("email"));
				c.setCellulare(rs.getString("cellulare"));
				c.setData_di_nascita(rs.getString("data_di_nascita"));
				c.setPassword(rs.getString("passwd"));
				c.setUsername(rs.getString("username"));
				c.setRuolo(rs.getString("ruolo"));
				c.setStatus(rs.getString("status"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return c;
	}
	
	public static int getIdByUsername(String username) {
	    int id = -1; 

	    String sql = "SELECT id FROM cliente WHERE username = ?";
	    try {
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ps.setString(1, username);
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            id = rs.getInt("id");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return id;
	}

	public static int update(Cliente c) {
	    int status = 0;
	    String sql = "update cliente set nome=?, cognome=?, email=?, cellulare=?, data_di_nascita=?, passwd=? where username=?";
	    try {
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ps.setString(1, c.getNome());
	        ps.setString(2, c.getCognome());
	        ps.setString(3, c.getEmail());
	        ps.setString(4, c.getCellulare());
	        ps.setString(5, c.getData_di_nascita());
	        ps.setString(6, c.getPassword());
	        ps.setString(7, c.getUsername());
	        ps.executeUpdate();

	        // Qui aggiorniamo lo username separatamente
	        String newUsername = c.getNome().substring(0, 2).toUpperCase() + c.getCognome().substring(0, 2).toUpperCase() + c.getData_di_nascita().substring(0, 4);
	        PreparedStatement ps1 = db.getConnection().prepareStatement("update cliente set username = ? where username = ?");
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
	        
	        logger.info("Update effettuato per l’utente " + c.getUsername());
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return status;
	}
	
	

	public static int delete(Cliente c) {
		int status = 0;
		System.out.println(c.toString());
		try {
			PreparedStatement ps = db.getConnection().prepareStatement("delete from cliente where username=?");
			ps.setString(1, c.getUsername());
			status = ps.executeUpdate();
			logger.info("Eliminato l’utente " + c.getUsername());
		} catch (Exception e) {
			System.out.println(e);
		}

		return status;
	}
	
	

	public static boolean login(Cliente c) {
        boolean accessoEffettuato = false;
        try {
            PreparedStatement ps = db.getConnection().prepareStatement("SELECT * FROM cliente WHERE username=? AND passwd=?");
            ps.setString(1, c.getUsername());
            ps.setString(2, c.getPassword());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");
                if ("A".equals(status)) {
                    accessoEffettuato = true;
                }
            }
            logger.info("Login effettuato per l’utente " + c.getUsername());
        } catch (Exception e) {
            System.out.println(e);
        }
        return accessoEffettuato;
    }
	
	public static int updateStatusEnabled(Cliente c) {
        int status = 0;
        try {
            PreparedStatement ps = db.getConnection().prepareStatement("update cliente set status = ? where username = ?");
            ps.setString(1, "A");
            ps.setString(2, c.getUsername());
            c.setStatus("A");
            status=ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static int updateStatusDisabled(Cliente c) {
        int status = 0;
        try {
            PreparedStatement ps = db.getConnection().prepareStatement("update cliente set status = ? where username = ?");
            ps.setString(1, "D");
            ps.setString(2, c.getUsername());
            c.setStatus("D");
            status=ps.executeUpdate();
            logger.info("Disabilitato l’utente " + c.getUsername());
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static int updateRuoloManager(Cliente c) {
        int status = 0;
        System.out.println("updateRuoloManager");
        try {
            PreparedStatement ps = db.getConnection().prepareStatement("update cliente set ruolo = ? where username = ?");
            ps.setString(1, "M");
            ps.setString(2, c.getUsername());
            c.setStatus("M");
            status=ps.executeUpdate();
            logger.info("Reso manager l’utente " + c.getUsername());
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
    
    public static int updateRuoloGuest(Cliente c) {
        int status = 0;
        try {
            PreparedStatement ps = db.getConnection().prepareStatement("update cliente set ruolo = ? where username = ?");
            ps.setString(1, "G");
            ps.setString(2, c.getUsername());
            c.setStatus("G");
            status=ps.executeUpdate();
            logger.info("Reso guest l’utente " + c.getUsername());
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

}