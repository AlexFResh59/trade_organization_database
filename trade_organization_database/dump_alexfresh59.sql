PGDMP         6            
    |            alexfresh59 %   12.20 (Ubuntu 12.20-0ubuntu0.20.04.1) %   12.20 (Ubuntu 12.20-0ubuntu0.20.04.1) 8    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16780    alexfresh59    DATABASE     }   CREATE DATABASE alexfresh59 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';
    DROP DATABASE alexfresh59;
                postgres    false            �           0    0    DATABASE alexfresh59    ACL     2   GRANT ALL ON DATABASE alexfresh59 TO alexfresh59;
                   postgres    false    3044                        2615    16949    trade_organization    SCHEMA     "   CREATE SCHEMA trade_organization;
     DROP SCHEMA trade_organization;
                alexfresh59    false            �            1259    16952 
   categories    TABLE     �   CREATE TABLE trade_organization.categories (
    category_id integer NOT NULL,
    category_name character varying(255) NOT NULL
);
 *   DROP TABLE trade_organization.categories;
       trade_organization         heap    alexfresh59    false    6            �            1259    16950    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_organization.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE trade_organization.categories_category_id_seq;
       trade_organization          alexfresh59    false    204    6            �           0    0    categories_category_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE trade_organization.categories_category_id_seq OWNED BY trade_organization.categories.category_id;
          trade_organization          alexfresh59    false    203            �            1259    16994 	   customers    TABLE     7  CREATE TABLE trade_organization.customers (
    customer_id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    phone character varying(20),
    email character varying(255),
    address character varying(255),
    CONSTRAINT customers_phone_check CHECK (((phone)::text ~ '^[0-9]+$'::text))
);
 )   DROP TABLE trade_organization.customers;
       trade_organization         heap    alexfresh59    false    6            �            1259    16992    customers_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_organization.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE trade_organization.customers_customer_id_seq;
       trade_organization          alexfresh59    false    6    210            �           0    0    customers_customer_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE trade_organization.customers_customer_id_seq OWNED BY trade_organization.customers.customer_id;
          trade_organization          alexfresh59    false    209            �            1259    16971    products    TABLE     �  CREATE TABLE trade_organization.products (
    product_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    stock_quantity integer NOT NULL,
    category_id integer,
    supplier_id integer,
    description text,
    CONSTRAINT products_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT products_stock_quantity_check CHECK ((stock_quantity >= 0))
);
 (   DROP TABLE trade_organization.products;
       trade_organization         heap    alexfresh59    false    6            �            1259    16969    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_organization.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE trade_organization.products_product_id_seq;
       trade_organization          alexfresh59    false    6    208            �           0    0    products_product_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE trade_organization.products_product_id_seq OWNED BY trade_organization.products.product_id;
          trade_organization          alexfresh59    false    207            �            1259    17021 	   saleitems    TABLE     @  CREATE TABLE trade_organization.saleitems (
    item_id integer NOT NULL,
    sale_id integer,
    product_id integer,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    CONSTRAINT saleitems_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT saleitems_quantity_check CHECK ((quantity > 0))
);
 )   DROP TABLE trade_organization.saleitems;
       trade_organization         heap    alexfresh59    false    6            �            1259    17019    saleitems_item_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_organization.saleitems_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE trade_organization.saleitems_item_id_seq;
       trade_organization          alexfresh59    false    214    6            �           0    0    saleitems_item_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE trade_organization.saleitems_item_id_seq OWNED BY trade_organization.saleitems.item_id;
          trade_organization          alexfresh59    false    213            �            1259    17006    sales    TABLE     (  CREATE TABLE trade_organization.sales (
    sale_id integer NOT NULL,
    sale_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    customer_id integer,
    total_amount numeric(10,2) NOT NULL,
    CONSTRAINT sales_total_amount_check CHECK ((total_amount >= (0)::numeric))
);
 %   DROP TABLE trade_organization.sales;
       trade_organization         heap    alexfresh59    false    6            �            1259    17004    sales_sale_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_organization.sales_sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE trade_organization.sales_sale_id_seq;
       trade_organization          alexfresh59    false    6    212            �           0    0    sales_sale_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE trade_organization.sales_sale_id_seq OWNED BY trade_organization.sales.sale_id;
          trade_organization          alexfresh59    false    211            �            1259    16960 	   suppliers    TABLE     �   CREATE TABLE trade_organization.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(255) NOT NULL,
    phone character varying(20),
    email character varying(255),
    address character varying(255)
);
 )   DROP TABLE trade_organization.suppliers;
       trade_organization         heap    alexfresh59    false    6            �            1259    16958    suppliers_supplier_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_organization.suppliers_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE trade_organization.suppliers_supplier_id_seq;
       trade_organization          alexfresh59    false    6    206            �           0    0    suppliers_supplier_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE trade_organization.suppliers_supplier_id_seq OWNED BY trade_organization.suppliers.supplier_id;
          trade_organization          alexfresh59    false    205            4           2604    16955    categories category_id    DEFAULT     �   ALTER TABLE ONLY trade_organization.categories ALTER COLUMN category_id SET DEFAULT nextval('trade_organization.categories_category_id_seq'::regclass);
 Q   ALTER TABLE trade_organization.categories ALTER COLUMN category_id DROP DEFAULT;
       trade_organization          alexfresh59    false    204    203    204            9           2604    16997    customers customer_id    DEFAULT     �   ALTER TABLE ONLY trade_organization.customers ALTER COLUMN customer_id SET DEFAULT nextval('trade_organization.customers_customer_id_seq'::regclass);
 P   ALTER TABLE trade_organization.customers ALTER COLUMN customer_id DROP DEFAULT;
       trade_organization          alexfresh59    false    209    210    210            6           2604    16974    products product_id    DEFAULT     �   ALTER TABLE ONLY trade_organization.products ALTER COLUMN product_id SET DEFAULT nextval('trade_organization.products_product_id_seq'::regclass);
 N   ALTER TABLE trade_organization.products ALTER COLUMN product_id DROP DEFAULT;
       trade_organization          alexfresh59    false    208    207    208            >           2604    17024    saleitems item_id    DEFAULT     �   ALTER TABLE ONLY trade_organization.saleitems ALTER COLUMN item_id SET DEFAULT nextval('trade_organization.saleitems_item_id_seq'::regclass);
 L   ALTER TABLE trade_organization.saleitems ALTER COLUMN item_id DROP DEFAULT;
       trade_organization          alexfresh59    false    214    213    214            ;           2604    17009    sales sale_id    DEFAULT     �   ALTER TABLE ONLY trade_organization.sales ALTER COLUMN sale_id SET DEFAULT nextval('trade_organization.sales_sale_id_seq'::regclass);
 H   ALTER TABLE trade_organization.sales ALTER COLUMN sale_id DROP DEFAULT;
       trade_organization          alexfresh59    false    211    212    212            5           2604    16963    suppliers supplier_id    DEFAULT     �   ALTER TABLE ONLY trade_organization.suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('trade_organization.suppliers_supplier_id_seq'::regclass);
 P   ALTER TABLE trade_organization.suppliers ALTER COLUMN supplier_id DROP DEFAULT;
       trade_organization          alexfresh59    false    206    205    206            �          0    16952 
   categories 
   TABLE DATA           L   COPY trade_organization.categories (category_id, category_name) FROM stdin;
    trade_organization          alexfresh59    false    204   -J       �          0    16994 	   customers 
   TABLE DATA           ^   COPY trade_organization.customers (customer_id, full_name, phone, email, address) FROM stdin;
    trade_organization          alexfresh59    false    210   �K       �          0    16971    products 
   TABLE DATA           �   COPY trade_organization.products (product_id, product_name, price, stock_quantity, category_id, supplier_id, description) FROM stdin;
    trade_organization          alexfresh59    false    208   FM       �          0    17021 	   saleitems 
   TABLE DATA           ^   COPY trade_organization.saleitems (item_id, sale_id, product_id, quantity, price) FROM stdin;
    trade_organization          alexfresh59    false    214   O       �          0    17006    sales 
   TABLE DATA           Z   COPY trade_organization.sales (sale_id, sale_date, customer_id, total_amount) FROM stdin;
    trade_organization          alexfresh59    false    212   zO       �          0    16960 	   suppliers 
   TABLE DATA           b   COPY trade_organization.suppliers (supplier_id, supplier_name, phone, email, address) FROM stdin;
    trade_organization          alexfresh59    false    206   P       �           0    0    categories_category_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('trade_organization.categories_category_id_seq', 50, true);
          trade_organization          alexfresh59    false    203            �           0    0    customers_customer_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('trade_organization.customers_customer_id_seq', 10, true);
          trade_organization          alexfresh59    false    209            �           0    0    products_product_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('trade_organization.products_product_id_seq', 10, true);
          trade_organization          alexfresh59    false    207            �           0    0    saleitems_item_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('trade_organization.saleitems_item_id_seq', 10, true);
          trade_organization          alexfresh59    false    213            �           0    0    sales_sale_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('trade_organization.sales_sale_id_seq', 10, true);
          trade_organization          alexfresh59    false    211            �           0    0    suppliers_supplier_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('trade_organization.suppliers_supplier_id_seq', 10, true);
          trade_organization          alexfresh59    false    205            B           2606    16957    categories categories_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY trade_organization.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 P   ALTER TABLE ONLY trade_organization.categories DROP CONSTRAINT categories_pkey;
       trade_organization            alexfresh59    false    204            J           2606    17003    customers customers_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY trade_organization.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);
 N   ALTER TABLE ONLY trade_organization.customers DROP CONSTRAINT customers_pkey;
       trade_organization            alexfresh59    false    210            H           2606    16981    products products_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY trade_organization.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 L   ALTER TABLE ONLY trade_organization.products DROP CONSTRAINT products_pkey;
       trade_organization            alexfresh59    false    208            O           2606    17028    saleitems saleitems_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY trade_organization.saleitems
    ADD CONSTRAINT saleitems_pkey PRIMARY KEY (item_id);
 N   ALTER TABLE ONLY trade_organization.saleitems DROP CONSTRAINT saleitems_pkey;
       trade_organization            alexfresh59    false    214            M           2606    17013    sales sales_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY trade_organization.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (sale_id);
 F   ALTER TABLE ONLY trade_organization.sales DROP CONSTRAINT sales_pkey;
       trade_organization            alexfresh59    false    212            D           2606    16968    suppliers suppliers_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY trade_organization.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);
 N   ALTER TABLE ONLY trade_organization.suppliers DROP CONSTRAINT suppliers_pkey;
       trade_organization            alexfresh59    false    206            E           1259    17042    idx_products_category_price    INDEX     j   CREATE INDEX idx_products_category_price ON trade_organization.products USING btree (category_id, price);
 ;   DROP INDEX trade_organization.idx_products_category_price;
       trade_organization            alexfresh59    false    208    208            F           1259    17039    idx_products_name    INDEX     Z   CREATE INDEX idx_products_name ON trade_organization.products USING btree (product_name);
 1   DROP INDEX trade_organization.idx_products_name;
       trade_organization            alexfresh59    false    208            K           1259    17040    idx_sales_date    INDEX     Q   CREATE INDEX idx_sales_date ON trade_organization.sales USING btree (sale_date);
 .   DROP INDEX trade_organization.idx_sales_date;
       trade_organization            alexfresh59    false    212            P           2606    16982 "   products products_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_organization.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES trade_organization.categories(category_id);
 X   ALTER TABLE ONLY trade_organization.products DROP CONSTRAINT products_category_id_fkey;
       trade_organization          alexfresh59    false    208    204    2882            Q           2606    16987 "   products products_supplier_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_organization.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES trade_organization.suppliers(supplier_id);
 X   ALTER TABLE ONLY trade_organization.products DROP CONSTRAINT products_supplier_id_fkey;
       trade_organization          alexfresh59    false    206    2884    208            T           2606    17034 #   saleitems saleitems_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_organization.saleitems
    ADD CONSTRAINT saleitems_product_id_fkey FOREIGN KEY (product_id) REFERENCES trade_organization.products(product_id);
 Y   ALTER TABLE ONLY trade_organization.saleitems DROP CONSTRAINT saleitems_product_id_fkey;
       trade_organization          alexfresh59    false    2888    208    214            S           2606    17029     saleitems saleitems_sale_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_organization.saleitems
    ADD CONSTRAINT saleitems_sale_id_fkey FOREIGN KEY (sale_id) REFERENCES trade_organization.sales(sale_id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY trade_organization.saleitems DROP CONSTRAINT saleitems_sale_id_fkey;
       trade_organization          alexfresh59    false    2893    212    214            R           2606    17014    sales sales_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_organization.sales
    ADD CONSTRAINT sales_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES trade_organization.customers(customer_id);
 R   ALTER TABLE ONLY trade_organization.sales DROP CONSTRAINT sales_customer_id_fkey;
       trade_organization          alexfresh59    false    210    2890    212            �   �  x�ER͒�0>KO�t����aK;�0egO��D	�M,��Ky���7Y�����}O�$������b�<�l{���ǚF�`��>�v�<q	�;'q�,<�5����W~����x	)=���%�$'Bc�=�/}/�� ��8��SC����4탒��g���^nhVp&�]r�W&k�&A��Sۆ��O��y5Z�w��oO��5�V�[;}�Ή�\�F�s�)$څ:B~�d�p��0'�+�:L�5\���W]v0�n��P���o��u
�q��(�:{E�L�X�>
%�!����n	?H�ާdT�ͧ�ה%Ծѭ�3ۏj�����%��R̺Q����A�*�.�:�Hy�	�.e���+�k�%����Ф��߹��Z���xµ�^m�� ^�.��Dl�����8��      �   N  x�U��n�0Eד��/@��]y��A%6ݘ�jI�L���w㻲�td�S��2
8�B��b�Q/�W6�ZM
� 1~H�᱋ldK�Fwx+������@M�w��AE1�e_�G^K)p#zv00����^:�Q[}�x�t��kj���2�m�
�PF)|�߬R-x1�@g��U0�KUJ�['�`�4Wr�w���h�` �,Ɠ�۾s=尬���dqo�(P8|v4l�%���gSS��m1��+��@��``�,����ų���֎n��H��P9J�����u���3��z���Ҏ�'��w�r|��e}O�(�,��      �   �  x�=�Mn�0�ףS�,�r��:Ml i4@�醦���������AP 1�߼�ލɏ�tMS7�;޼^D��и�4ƛg�F\���crATW-�}r�m�l��qRø�..a%�^d�g�Qv@a{�]����r�>h�l
뾁���fM?�JU�sz|�����������>:��[0mF�zaOi���p�Ŭ[\�B�/�����YM�g7]I�)n�U�#Y<�jqa&��ׄ��)%�Ǻ���?�a*�3�.�`�ap�%�].�3�YU�z2g0N޻��j�U M1�D�$¾8k��5��ձ��y������x�RW��&�?{�T��7'�����R/����SO}]�y��y2�^��o`GW>8�U&
�,x�)	9�����dR���$͐�JN��>�I/�\�:�ux�B���ٞ���x�ꪪ����V      �   O   x�-��� C��gC��K���5�^.��5�4L�8�c"�=ˁ�5�&�e��o(_oL�6&�I
��:SO-��p��      �   z   x�e��!�w��XC`k���]�.�=�,C�6�����n�a!�V��R5Ro�UOR]N�%RB&�T�_�"�2�E�hz֟��j�z�3k�
RS�F+�ZAS_�b{���R~dD      �   S  x�=��n�0E��� �v�J��"�R	���$� Od;T��׎+��=�̝>��_H���Y^�U�В����u�ul���s���h5�e)��[�n@QN�L�H�6��׀�\�{����Xk�ۉ����0�5gG�=�=G����Մ,��`�������bs	���an������ٱh?I!D5��h��T��E�I��6����&�ZF��4��FM��������b�&K�&�h�aS���IhH��g]Ŭ�ס3GK!JU,���pQp�.a?���K5H�j�|x��t�KQ�Y��D�V�jr���{���������d��k���w�5     