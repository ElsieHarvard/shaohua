class CreateArticle < ActiveRecord::Migration
  def change
    create_table :articles do |t|
		t.string :arc_title             
		t.string :arc_type              
		t.string :arc_preauthor         
		t.string :arc_author            
		t.text :arc_beforecontent     
		t.string :arc_attrbeforecontent 
		t.text :arc_content           
		t.string :arc_attraftercontent  
		t.text :arc_aftercontent      
		t.string :arc_picture           
		t.string :arc_prdhash           
		t.string :arc_prdnumber         
		t.integer :arc_view              
		t.integer :arc_top               
		t.text :arc_tag               
		t.string :arc_hash
    end
  end
end
