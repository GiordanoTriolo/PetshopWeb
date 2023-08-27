package it.betacom.bean;

public class Customer {

	private int id;
	private String nome;
	private String cognome;
	private String username;
	private String password;
	private String indirizzo;
	private String citta;
	private String data_di_nascita;
	private String cellulare;
	private String ruolo;
	private String status;
	private int failedLoginAttempts = 0;
	
	public Customer() {
	}

	public final int getId() {
		return id;
	}

	public final void setId(int id) {
		this.id = id;
	}

	public final String getNome() {
		return nome;
	}

	public final void setNome(String nome) {
		this.nome = nome;
	}

	public final String getCognome() {
		return cognome;
	}

	public final void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public final String getUsername() {
		return username;
	}

	public final void setUsername(String username) {
		this.username = username;
	}

	public final String getPassword() {
		return password;
	}

	public final void setPassword(String password) {
		this.password = password;
	}

	public final String getIndirizzo() {
		return indirizzo;
	}

	public final void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public final String getCitta() {
		return citta;
	}

	public final void setCitta(String citta) {
		this.citta = citta;
	}

	public final String getData_di_nascita() {
		return data_di_nascita;
	}

	public final void setData_di_nascita(String data_di_nascita) {
		this.data_di_nascita = data_di_nascita;
	}

	public final String getCellulare() {
		return cellulare;
	}

	public final void setCellulare(String cellulare) {
		this.cellulare = cellulare;
	}

	
	public final String getRuolo() {
		return ruolo;
	}

	public final void setRuolo(String ruolo) {
		this.ruolo = ruolo;
	}

	public final String getStatus() {
		return status;
	}

	public final void setStatus(String status) {
		this.status = status;
	}

	public final int getFailedLoginAttempts() {
		return failedLoginAttempts;
	}

	public final void setFailedLoginAttempts(int failedLoginAttempts) {
		this.failedLoginAttempts = failedLoginAttempts;
	}
	
	public final void incrementFailedLoginAttempts() {
        this.failedLoginAttempts++;
    }

	@Override
	public String toString() {
		return "Customer [id=" + id + ", nome=" + nome + ", cognome=" + cognome + ", username=" + username
				+ ", password=" + password + ", indirizzo=" + indirizzo + ", citta=" + citta + ", data_di_nascita="
				+ data_di_nascita + ", cellulare=" + cellulare + "]";
	}

	
	
}
