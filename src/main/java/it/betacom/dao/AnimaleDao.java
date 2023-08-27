package it.betacom.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import it.betacom.bean.Animale;
import it.betacom.connection.DBHandler;

public class AnimaleDao {
	public static DBHandler db = DBHandler.getInstance();
	
	private static final Logger logger = LogManager.getLogger(AnimaleDao.class);
	
	public static int save(Animale a) {
		int status=0;
		String sql = "INSERT INTO animale (nome_animale, tipo_animale,prezzo) VALUES(?,?,?)";
		try {
			PreparedStatement ps = db.getConnection().prepareStatement(sql);
			ps.setString(1, a.getNomeAnimale());
			ps.setString(2, a.getTipoAnimale());
			ps.setDouble(3, a.getPrezzo());
			status=ps.executeUpdate();
			logger.info("Inserimento animale " + a.getMatricola() + " avvenuto");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public static List<Animale> getAllRecords() {
	    List<Animale> list = new ArrayList<Animale>();
	    String sql = "SELECT a.matricola, a.nome_animale, a.data_di_acquisto, a.tipo_animale, a.prezzo,a.id_cliente ,c.nome, c.cognome " +
	                 "FROM animale a " +
	                 "JOIN customers c ON a.id_cliente = c.id_customer ORDER BY a.matricola ASC";

	    try {
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Animale a = new Animale();
	            a.setMatricola(rs.getInt("matricola"));
	            a.setNomeAnimale(rs.getString("nome_animale"));
	            a.setDataAcquisto(rs.getString("data_di_acquisto"));
	            a.setTipoAnimale(rs.getString("tipo_animale"));
	            a.setPrezzo(rs.getDouble("prezzo"));
	            a.setIdCliente(rs.getInt("id_cliente"));
	            a.setProprietario(rs.getString("nome")+ " " +rs.getString("cognome"));

	            list.add(a);
	        }
	        rs.close();
	        ps.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	
	public static List<Animale> getAllRecordsWithNullIdCliente() {
	    List<Animale> list = new ArrayList<Animale>();
	    String sql = "SELECT a.matricola, a.nome_animale, a.data_di_acquisto, a.tipo_animale, a.prezzo,a.id_cliente ,c.nome, c.cognome " +
	                 "FROM animale a " +
	                 "LEFT JOIN customers c ON a.id_cliente = c.id_customer " +
	                 "WHERE a.id_cliente IS NULL " +
	                 "ORDER BY a.matricola ASC";

	    try {
	        PreparedStatement ps = db.getConnection().prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Animale a = new Animale();
	            a.setMatricola(rs.getInt("matricola"));
	            a.setNomeAnimale(rs.getString("nome_animale"));
	            a.setDataAcquisto(rs.getString("data_di_acquisto"));
	            a.setTipoAnimale(rs.getString("tipo_animale"));
	            a.setPrezzo(rs.getDouble("prezzo"));
	            a.setIdCliente(rs.getInt("id_cliente"));
	            a.setProprietario(rs.getString("nome") + " " + rs.getString("cognome"));

	            list.add(a);
	        }
	        rs.close();
	        ps.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

		public static Animale getRecordByMatricola(int matricola){
			Animale a = new Animale();
			String sql = "select * from animale where matricola=?";
			try{
				PreparedStatement ps=db.getConnection().prepareStatement(sql);
				ps.setInt(1,matricola);
				ResultSet rs=ps.executeQuery();
				while(rs.next()){
					a.setMatricola(rs.getInt("matricola"));
					a.setNomeAnimale(rs.getString("nome_animale"));
					a.setDataAcquisto(rs.getString("data_di_acquisto"));
					a.setTipoAnimale(rs.getString("tipo_animale"));
					a.setPrezzo(rs.getDouble("prezzo"));
				}
			}catch(Exception e){System.out.println(e);}
			return a;
		}
		
		public static int update(Animale a) {
	        int status = 0;
	        String sql = "update animale set nome_animale=?, tipo_animale=?, prezzo=? where matricola=?";
	        try {
	            PreparedStatement ps = db.getConnection().prepareStatement(sql);
				ps.setString(1, a.getNomeAnimale());
				ps.setString(2, a.getTipoAnimale());
				ps.setDouble(3, a.getPrezzo());
				ps.setInt(4, a.getMatricola());
	            status = ps.executeUpdate();
	            logger.info("Update animale " + a.getMatricola() + " avvenuto");
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        return status;
	    }

		public static int delete(Animale a) {
			int status = 0;
			try {
				PreparedStatement ps = db.getConnection().prepareStatement("delete from animale where matricola=?");
				ps.setDouble(1, a.getMatricola());
				status = ps.executeUpdate();
				logger.info("Eliminazione animale " + a.getMatricola() + " avvenuta");
			} catch (Exception e) {
				System.out.println(e);
			}

			return status;
		}
	
		public static List<Animale> getAllRecordsView(int id_cliente) {
		    List<Animale> list = new ArrayList<Animale>();
		    String sql = "SELECT a.matricola, a.nome_animale, a.data_di_acquisto, a.tipo_animale, a.prezzo, a.id_cliente "
		            + "FROM animale a JOIN customers c ON a.id_cliente = c.id_customer "
		            + "WHERE a.id_cliente = ?";

		    try {
		        PreparedStatement ps = db.getConnection().prepareStatement(sql);
		        ps.setInt(1, id_cliente);
		        ResultSet rs = ps.executeQuery();

		        while (rs.next()) {
		            Animale a = new Animale();

		            a.setMatricola(rs.getInt("matricola"));
		            a.setNomeAnimale(rs.getString("nome_animale"));          
		            a.setDataAcquisto(rs.getString("data_di_acquisto"));
		            a.setTipoAnimale(rs.getString("tipo_animale"));
		            a.setPrezzo(rs.getDouble("prezzo"));
		            a.setIdCliente(rs.getInt("id_cliente"));

		            list.add(a);
		        }

		        rs.close();
		        ps.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return list;
		}
		
		
		public static String getNameByIdCliente(int id_cliente) {
		    String proprietario = null;
		    String sql = "SELECT c.nome, c.cognome "
		            + "FROM animale a JOIN customers c ON a.id_cliente = c.id_customer "
		            + "WHERE a.id_cliente = ?";
		    try {
		        PreparedStatement ps = db.getConnection().prepareStatement(sql);
		        ps.setInt(1, id_cliente);
		        ResultSet rs = ps.executeQuery();

		        while (rs.next()) {
		            String nome = rs.getString("nome");
		            String cognome = rs.getString("cognome");
		            
		            if (nome != null && cognome != null) {
		                proprietario = nome + " " + cognome;
		                break;  // Se trovi una corrispondenza valida, esci dal loop
		            }
		        }

		        rs.close();
		        ps.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return proprietario;
		}
		
}