CREATE DATABASE medical_clinic

CREATE TABLE medical_histories (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INTEGER,
  status VARCHAR(150),
  PRIMARY KEY (id),
  FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
  FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE
  FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE CASCADE
);

CREATE TABLE patients (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(150),
  date_of_birth DATE
  PRIMARY KEY (id),
);

CREATE TABLE invoice_items (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  unit_price DECIMAL,
  quantity INTEGER,
  total_price DECIMAL,
  invoice_id INTEGER,
  treatment_id INTEGER,
  PRIMARY KEY (id),
  FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE
  FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE CASCADE
);

CREATE TABLE treatments (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  type VARCHAR(150),
  name VARCHAR(150),
  PRIMARY KEY (id),
);

CREATE TABLE invoices (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INTEGER,
  PRIMARY KEY (id),
);
