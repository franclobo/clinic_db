-- Create the clinic database.
CREATE DATABASE clinic
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- Create medical_histories table.
CREATE TABLE public.medical_histories
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    admited_at timestamp with time zone,
    patient_id integer,
    status text,
    CONSTRAINT pk_medical_histories PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.medical_histories
    OWNER to postgres;

COMMENT ON TABLE public.medical_histories
    IS 'Create medical_histories';

-- Create patients table.
CREATE TABLE public.patients
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text,
    date_of_birth date,
    PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.patients
    OWNER to postgres;

COMMENT ON TABLE public.patients
    IS 'Create patients table.';

-- Create invoice_items table.
CREATE TABLE public.invoice_items
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    unit_price numeric,
    quantity integer,
    total_price numeric,
    invoice_id integer,
    treatment_id integer,
    PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoice_items
    OWNER to postgres;

COMMENT ON TABLE public.invoice_items
    IS 'create invoice_items table';

-- Create invoice table.
CREATE TABLE public.invoice
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    total_amount numeric,
    generated_at timestamp with time zone,
    payed_at timestamp with time zone,
    medical_history_id integer,
    PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoice
    OWNER to postgres;

COMMENT ON TABLE public.invoice
    IS 'create invoice table';

-- Create treatments table.
CREATE TABLE public.treatments
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    type character varying(30),
    name character varying(30),
    PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.treatments
    OWNER to postgres;

-- Create medical_treatments join table.
CREATE TABLE public.medical_treatments
(
    medical_history_id integer NOT NULL,
    treatments_id integer NOT NULL,
    PRIMARY KEY (medical_history_id, treatments_id),
    CONSTRAINT medical_fk FOREIGN KEY (medical_history_id)
        REFERENCES public.medical_histories (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT treatments_fk FOREIGN KEY (treatments_id)
        REFERENCES public.treatments (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.medical_treatments
    OWNER to postgres;

--Join medical_histories with patients.

ALTER TABLE IF EXISTS public.medical_histories
    ADD CONSTRAINT fk_patients FOREIGN KEY (patient_id)
    REFERENCES public.patients (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

-- Join medical_histories with invoices.
ALTER TABLE IF EXISTS public.invoices
    ADD CONSTRAINT " medical_fk" FOREIGN KEY (medical_history_id)
    REFERENCES public.medical_histories (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
    
-- Join invoice_items with invoices.
ALTER TABLE IF EXISTS public.invoice_items
    ADD CONSTRAINT fk_invoice FOREIGN KEY (invoice_id)
    REFERENCES public.invoice (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
    
-- Join invoice_items with treatments.
ALTER TABLE IF EXISTS public.invoice_items
    ADD CONSTRAINT fk_treatment FOREIGN KEY (treatment_id)
    REFERENCES public.treatments (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
