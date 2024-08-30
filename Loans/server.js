const express = require('express')
const app = express()
const port = 3001
const cors = require("cors")
const mysql = require('mysql');
const path = require("path")
const dotenv = require("dotenv")
const jwt = require("jsonwebtoken")
const multer = require("multer")
const fs = require('fs');
dotenv.config({ path:'./.env'})

app.use(cors());
app.use(express.json());

app.use('/', express.static(path.join(__dirname, '/')));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
  cb(null, "uploads");
  },
  filename: function (req, file, cb) {
  cb(null, Date.now() + "-" + file.originalname);
  },
});

upload = multer({ storage: storage });

const key = "This is a Secret Key"



const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'loanlink',
});

  
db.connect((err) => {
    if (err) {
      console.error('Error connecting to the database:', err);
      return;
    }
    console.log(`Connected to the database at port ${port}`);
});

//==================================Users======================================

//Basics

app.post('/signup', (req, res) => {
    jwt.sign(req.body.password, key, (err, token) => {
      const query = `INSERT INTO customers(name, email, mobile, gender, password) VALUES(?)`; 
      const values = [req.body.name, req.body.email, req.body.mobile, req.body.gender, token]
      db.query(query,[values], (err, results) => {
        if (err) {
            if (err.errno == 1062)
            {
                res.json(err.errno)
                return;
            }
            else{
                res.status(500).json({ error: 'Error fetching data from the database' });
                console.error('Error executing the query:', err);

                return;
            }
          console.error('Error executing the query:', err);
        }
        res.json(results);
      });
    //   console.log('token = ', token)
    })
    //mailsender(req.body.mail)       //uncomment this to send mail
}); 

app.post('/login', (req, res) => {
    jwt.sign(req.body.password, key, (err, token) => {
      const query = `SELECT * FROM customers WHERE email = "${req.body.email}" AND password = "${token}";`; 
      db.query(query, (err, results) => {
        if (err) {
          console.error('Error executing the query:', err);
          res.json({ error: 'Error fetching data from the database' });
        }
        if(results.length > 0)
        {
          const ndate = new Date()
        //   .toLocaleString()
          jwt.sign({User_Id: results[0].id, User_name : results[0].name, Ip : req.body.ip, date : ndate}, key, (err, token) => {
            res.json(token);
          })
        }
        else{
          res.json(results)
        }
      });
    })
});

app.post('/validate',(req,res) => {
    jwt.verify(req.body.token, key, (err, authData) => {
      if(err){
        res.sendStatus(403)
      }
      else{
        let token_date = new Date(authData.date);
        let current_date = new Date();
        let difference = current_date - token_date;
        let diff_in = difference / (1000 * 60 * 60);
        if(diff_in > 3)
        {
            res.json(false) 
        }
        else{
            res.json(true)
        }
        console.log(token_date, current_date, diff_in)
      }
    })
})

//


//==================================Admin======================================
//Loan Types

app.post("/add_loan_types", upload.single("file"),(req, res) => {
  const query = `INSERT INTO loan_types(loan_name, interest_rate, gist, summary, description, image, tc_id) VALUES(?,?,?,?,?,?,?);`;
  const values = [req.body.name, req.body.rate, req.body.gist, req.body.summary, req.body.description, req.file.filename, req.body.tc_id]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.post("/edit_loan_image/:id", upload.single("file"), (req, res) => {
  const query = `UPDATE loan_types SET image = ? WHERE id = ${req.params.id};`;
  const values = [req.file.filename]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.post("/edit_loan_types/:id", upload.single("file"), (req, res) => {
  const query = `UPDATE loan_types SET loan_name = ?, gist = ?, summary = ?, description = ?, tc_id = ?, interest_rate = ? WHERE id = ${req.params.id};`;
  const values = [req.body.name, req.body.gist, req.body.summary,req.body.description, req.body.tc_id, req.body.rate]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/get_loan_types", (req, res) => {
  const query = `SELECT * FROM loan_types;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/get_specific_loan_types/:id", (req, res) => {
  const query = `SELECT loan_types.*, tc.conditions FROM loan_types JOIN tc ON tc.id = loan_types.tc_id WHERE loan_types.id=${req.params.id};`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/activate_loan_types/:id", (req, res) => {
  const query = `UPDATE loan_types SET status = CASE WHEN status = 0 THEN 1 ELSE 0 END WHERE id = ${req.params.id};`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/active_loan_types", (req, res) => {
  const query = `SELECT loan_types.*, tc.conditions FROM loan_types JOIN tc ON tc.id = loan_types.tc_id WHERE loan_types.status = 1;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});


//Document Types

app.post("/add_doc_type", (req, res) => {
  const query = `INSERT INTO documents(document_name) VALUES(?);`;
  const values = [req.body.name]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.post("/edit_doc_type/:id", (req, res) => {
  const query = `UPDATE documents SET document_name = ? WHERE id = ${req.params.id};`;
  const values = [req.body.name]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/get_doc_type", (req, res) => {
  const query = `SELECT * FROM documents;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/activate_doc_type/:id", (req, res) => {
  const query = `UPDATE documents SET status = CASE WHEN status = 0 THEN 1 ELSE 0 END WHERE id = ${req.params.id};`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/active_doc_type", (req, res) => {
  const query = `SELECT * FROM documents WHERE status = 1;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//Ocupation Types

app.post("/add_occupation", (req, res) => {
  const query = `INSERT INTO occupation(occupation_name) VALUES(?);`;
  const values = [req.body.name]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.post("/edit_occupation/:id", (req, res) => {
  const query = `UPDATE occupation SET occupation_name = ? WHERE id = ${req.params.id};`;
  const values = [req.body.name]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/get_occupation", (req, res) => {
  const query = `SELECT * FROM occupation;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/activate_occupation/:id", (req, res) => {
  const query = `UPDATE occupation SET status = CASE WHEN status = 0 THEN 1 ELSE 0 END WHERE id = ${req.params.id};`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/active_occupation", (req, res) => {
  const query = `SELECT * FROM occupation WHERE status = 1;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//Income Range

app.post("/add_income", (req, res) => {
  const query = `INSERT INTO income_category(max_income) VALUES(?);`;
  const values = [req.body.category]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.post("/edit_income/:id", (req, res) => {
  const query = `UPDATE income_category SET max_income = ? WHERE id = ${req.params.id};`;
  const values = [req.body.name]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/get_income", (req, res) => {
  const query = `SELECT * FROM income_category;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/activate_income/:id", (req, res) => {
  const query = `UPDATE income_category SET status = CASE WHEN status = 0 THEN 1 ELSE 0 END WHERE id = ${req.params.id};`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/active_income", (req, res) => {
  const query = `SELECT * FROM income_category WHERE status = 1 ORDER BY CAST(max_income AS UNSIGNED) ASC;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//Tand C 

app.post("/add_tc", (req, res) => {
  const query = `INSERT INTO tc(tc_name, conditions) VALUES(?,?);`;
  const values = [req.body.name,req.body.terms]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.post("/edit_tc/:id", (req, res) => {
  const query = `UPDATE tc SET conditions = ? WHERE id = ${req.params.id};`;
  const values = [req.body.terms]
  db.query(query, values ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/get_tc", (req, res) => {
  const query = `SELECT * FROM tc;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/activate_tc/:id", (req, res) => {
  const query = `UPDATE tc SET status = CASE WHEN status = 0 THEN 1 ELSE 0 END, updated_at = CURRENT_TIMESTAMP WHERE id = ${req.params.id};`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.get("/active_tc", (req, res) => {
  const query = `SELECT * FROM tc WHERE status = 1;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//all customers
app.get("/get_customers", (req, res) => {
  const query = `SELECT customers.*, customers.id AS cid, COUNT(applications.customer_id) AS application_count FROM customers LEFT JOIN applications ON customers.id = applications.customer_id GROUP BY customers.id;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//1 customers
app.get("/customer_info/:id", (req, res) => {
  const query = `SELECT customers.*, customer_info.*, income_category.max_income, occupation.occupation_name FROM customers JOIN customer_info ON customers.id = customer_info.customer_id JOIN income_category ON income_category.id = customer_info.income_id JOIN occupation ON occupation.id = customer_info.occupation_id WHERE customers.id = ${req.params.id}`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//1 customer loans customer_loans
app.get("/customer_loans/:id", (req, res) => {
  const query = `SELECT applications.*, loan_types.loan_name FROM applications JOIN loan_types ON applications.loan_id = loan_types.id WHERE applications.customer_id = ${req.params.id}`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//update_application_status
app.post("/update_application_status", (req, res) => {
  const query = `UPDATE applications SET status = ${req.body.status} WHERE id = ${req.body.app_id};`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//all_ratings
app.get("/all_ratings", (req, res) => {
  const query = `SELECT ratings.*, loan_types.loan_name, customers.name FROM ratings JOIN loan_types ON ratings.loan_id = loan_types.id JOIN customers ON customers.id = ratings.customer_id`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});
//================================================

// customer_info:
app.post("/add_customer_info",upload.fields([{ name: 'aadhar_doc', maxCount: 1 }, { name: 'pan_doc', maxCount: 1 }, { name: 'income_statement', maxCount: 1 }, { name: 'photo', maxCount: 1 } ]), (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      console.log(req.files.aadhar_doc[0].filename)
      const query = `INSERT INTO customer_info(customer_id, present_address, permanent_address, birthday, income_id, income, occupation_id, occupation, aadhar_no, aadhar_doc, pan_no, pan_doc, income_statement, emi_amount, photo) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);`;
      const values = [authData.User_Id,req.body.present_address,req.body.permanent_address,req.body.dob,req.body.income_id,req.body.income,req.body.occupation_id,req.body.occupation,req.body.aadhar_no,req.files.aadhar_doc[0].filename,req.body.pan_no,req.files.pan_doc[0].filename,req.files.income_statement[0].filename,req.body.emi,req.files.photo[0].filename]
      
      db.query(query, values ,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

// customer_info get specific user:
app.post("/get_specific_customer_info", (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `SELECT customers.*, customer_info.*, income_category.max_income, occupation.occupation_name FROM customers JOIN customer_info ON customers.id = customer_info.customer_id JOIN income_category ON income_category.id = customer_info.income_id JOIN occupation ON occupation.id = customer_info.occupation_id WHERE customers.id = ${authData.User_Id};`;
      db.query(query ,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});


//Applications:
app.post("/add_application", (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `INSERT INTO applications(customer_id,loan_id,interest_rate,principle,remaining,years, description, interest_amount) VALUES(?,?,?,?,?,?,?,?) ;`;
      const values = [authData.User_Id, req.body.loan_id, req.body.rate, req.body.principle, req.body.remaining, req.body.years, req.body.description, req.body.remaining]
      db.query(query, values ,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

//my loans
app.post("/my_loans", (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `SELECT applications.*, applications.id as aid, applications.created_at as aca, applications.description as ades, applications.status AS astatus, loan_types.* FROM applications JOIN loan_types ON applications.loan_id = loan_types.id WHERE applications.customer_id = "${authData.User_Id}" ;`;
      db.query(query ,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

//filter_loans
app.post("/filter_my_loans", (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `SELECT applications.*, applications.id as aid, applications.created_at as aca, applications.description as ades, loan_types.* FROM applications JOIN loan_types ON applications.loan_id = loan_types.id WHERE applications.customer_id = "${authData.User_Id}" AND applications.status = ${req.body.filter} ;`;
      db.query(query ,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

//my loans
app.get("/my_loan/:id", (req, res) => {
  const query = `SELECT applications.*, applications.created_at as aca, loan_types.*, tc.conditions FROM applications JOIN loan_types ON applications.loan_id = loan_types.id JOIN tc ON tc.id = loan_types.tc_id WHERE applications.id = "${req.params.id}" ;`;
  db.query(query ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});


//EMI table
app.get("/emi_table/:id", (req, res) => {
  const query = `SELECT emi.*, emi.id AS eid, loan_types.loan_name, applications.*,emi.status AS estatus from emi JOIN loan_types ON loan_types.id = emi.loan_id JOIN applications ON applications.id = emi.application_id WHERE emi.application_id = "${req.params.id}" ;`;
  db.query(query ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//add EMI:
app.post("/add_emi", (req, res) => {
  const query = `INSERT INTO emi(customer_id,loan_id,application_id,amount,due_date) VALUES("${req.body.customer_id}","${req.body.loan_id}","${req.body.application_id}","${req.body.amount}","${req.body.date}");`;
  db.query(query ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});



//pay EMI:
app.get("/pay_emi/:id", (req, res) => {
  const query = `UPDATE emi SET status = 1 WHERE id = ${req.params.id};`;
  db.query(query ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//pay principle:
app.post("/pay_principle", (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `INSERT INTO principle(customer_id,loan_id,application_id,amount) VALUES("${authData.User_Id}","${req.body.loan_id}","${req.body.application_id}","${req.body.amount}");`;
      db.query(query ,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

app.get("/get_principle/:id", (req, res) => {
  const query = `SELECT principle.*, applications.interest_amount FROM principle JOIN applications ON applications.id=principle.application_id WHERE application_id = ${req.params.id};`;
  db.query(query ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//remaining_emi:
app.get("/remaining_emi/:id", (req, res) => {
  const query = `SELECT * FROM emi WHERE status = 0 AND application_id = ${req.params.id};`;
  db.query(query ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//emi_reducer:
app.post("/emi_reducer", (req, res) => {
  const query = `UPDATE emi SET amount = "${req.body.amount}" WHERE status = 0 AND application_id = ${req.body.id};`;
  db.query(query ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//reducer:
app.post("/reducer", (req, res) => {
  const query = `UPDATE applications SET remaining = remaining-${req.body.amount} WHERE id = "${req.body.id}" ;`;
  db.query(query ,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});


// Update user info
app.post("/update_docs", (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `UPDATE customer_info SET income_id = ?, occupation_id = ?, income = ?, emi_amount = ?, occupation = ?, updated_at = CURRENT_TIMESTAMP WHERE customer_id = ${authData.User_Id};`;
      const values = [req.body.income_id, req.body.occupation_id, req.body.income, req.body.emi, req.body.occupation]
      db.query(query, values ,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

// Update user 
app.post("/update_user", (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `UPDATE customers SET name = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ${authData.User_Id};`;
      const values = [req.body.name]
      db.query(query, values ,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

// Update aadhar
app.post("/update_aadhar",upload.single("file"), (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `UPDATE customer_info SET aadhar_doc = "${req.file.filename}", updated_at = CURRENT_TIMESTAMP WHERE customer_id = ${authData.User_Id};`;
      
      db.query(query,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

// Update pan
app.post("/update_pan",upload.single("file"), (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `UPDATE customer_info SET pan_doc = "${req.file.filename}", updated_at = CURRENT_TIMESTAMP WHERE customer_id = ${authData.User_Id};`;
      
      db.query(query,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

// Update income_tatement
app.post("/update_income_statement",upload.single("file"), (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `UPDATE customer_info SET income_statement = "${req.file.filename}", updated_at = CURRENT_TIMESTAMP WHERE customer_id = ${authData.User_Id};`;
      
      db.query(query,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

// Update photo
app.post("/update_photo",upload.single("file"), (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `UPDATE customer_info SET photo = "${req.file.filename}", updated_at = CURRENT_TIMESTAMP WHERE customer_id = ${authData.User_Id};`;
      
      db.query(query,(err, result) => {
        if (err) {
          res.status(500).send(err);
          console.log(err)
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});


// Add Feedback
app.post("/add_feedback", (req, res) => {
  jwt.verify(req.body.token, key, (err, authData) => {
    if(err){
      res.sendStatus(403)
    }
    else{
      const query = `INSERT INTO ratings(customer_id, loan_id, description, ratings) VALUES(?,?,?,?) ;`;
      const values = [authData.User_Id, req.body.loan_id, req.body.description, req.body.ratings]
      db.query(query, values,(err, result) => {
        if (err) {
          if(err.errno == 1062)
          {
            res.json(err.errno)
          }
          else{
            res.status(500).send(err);
            console.log(err)
          }
        } 
        else {
          res.json(result)
        }
      });
    }
  })
});

//contact
app.post("/contact", (req, res) => {
  const query = `INSERT INTO contacts(name, email, mobile, message) VALUES(?,?,?,?);`;
  const values = [req.body.name,req.body.email,req.body.mobile,req.body.message]
  db.query(query, values,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//get contact
app.get("/get_contact", (req, res) => {
  const query = `SELECT * FROM contacts;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//update_stats:
app.post("/update_stats", (req, res) => {
  const query = `UPDATE emi SET status = "${req.body.status}" WHERE id = ${req.body.id};`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

//over_due customers contact
app.get("/get_over_due", (req, res) => {
  const query = `SELECT emi.*, applications.principle, customers.name, customers.id AS cid, loan_types.loan_name FROM emi JOIN customers ON customers.id = emi.customer_id JOIN loan_types ON loan_types.id = emi.loan_id JOIN applications ON emi.application_id = applications.id WHERE emi.status = 2;`;
  db.query(query,(err, result) => {
    if (err) {
      res.status(500).send(err);
      console.log(err)
    } 
    else {
      res.json(result)
    }
  });
});

app.listen(port,"192.168.29.108", () => {
    console.log(`Example apps listening on port ${port}`)
}) 
// "192.168.29.108",

// CREATE TABLE `loanlink`.`customer_info` (`id` INT NOT NULL AUTO_INCREMENT , `customer_id` INT NOT NULL , `income_id` INT NOT NULL , `aadhar_number` VARCHAR(100) NOT NULL , `pan_no` VARCHAR(100) NOT NULL , `occupation_id` INT NOT NULL , `income` VARCHAR(100) NOT NULL , `aadhar_doc` VARCHAR(100) NOT NULL , `pan_doc` VARCHAR(100) NOT NULL , `emi_amount` VARCHAR(100) NOT NULL , `occupation` VARCHAR(100) NULL DEFAULT NULL , `photo` VARCHAR(100) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , PRIMARY KEY (`id`)) ENGINE = InnoDB;