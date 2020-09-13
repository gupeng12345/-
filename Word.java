package edu.gu;

public class Word implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String word;
	private Integer count;
	
	public Word() {
		
	}
	
    public String getWord(){
        return this.word;
    }

    public void setWord(String word){
        this.word = word;
    }

    public Integer getCount(){
        return this.count;
    }

    public void setCount(Integer count){
        this.count = count;
    }    

}
