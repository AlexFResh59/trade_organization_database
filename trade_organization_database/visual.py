import tkinter as tk
from tkinter import messagebox
import psycopg2

# Подключение к базе данных PostgreSQL
def connect_db():
    return psycopg2.connect(
        dbname="alexfresh59",
        user="alexfresh59",
        password="492760",
        host="localhost"
    )

# Основной класс для интерфейса
class DatabaseApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Управление базой данных торговой организации")

        # Создание контейнера для вкладок
        self.tab_control = tk.Frame(root)
        self.tab_control.pack()

        self.create_main_interface()

    # Функция для создания главного интерфейса
    def create_main_interface(self):
        self.clear_frame()
        tk.Label(self.root, text="Главное меню").pack()

        # Кнопки для каждой вкладки
        self.tabs = {
            "Товары": self.create_products_tab,
            "Клиенты": self.create_clients_tab,
            "Продажи": self.create_sales_tab
        }
        for tab_name, tab_func in self.tabs.items():
            button = tk.Button(self.root, text=tab_name, command=tab_func)
            button.pack(pady=5)

    # Вкладка для работы с товарами
    def create_products_tab(self):
        self.clear_frame()
        tk.Label(self.root, text="Товары").pack()

        # Кнопка для возврата в главное меню
        tk.Button(self.root, text="Назад в меню", command=self.create_main_interface).pack()

        # Кнопка для отображения всех товаров
        tk.Button(self.root, text="Показать товары", command=self.show_products).pack()

        # Форма для добавления нового товара
        tk.Label(self.root, text="Добавить новый товар").pack()
        self.product_name_entry = tk.Entry(self.root)
        self.product_name_entry.insert(0, "Название товара")
        self.product_price_entry = tk.Entry(self.root)
        self.product_price_entry.insert(0, "Цена")
        self.product_quantity_entry = tk.Entry(self.root)
        self.product_quantity_entry.insert(0, "Количество")
        
        # Дополнительные поля, если они нужны в таблице products
        self.product_supplier_id_entry = tk.Entry(self.root)
        self.product_supplier_id_entry.insert(0, "ID поставщика")
        self.product_category_entry = tk.Entry(self.root)
        self.product_category_entry.insert(0, "Категория")
        self.product_description_entry = tk.Entry(self.root)
        self.product_description_entry.insert(0, "Описание")

        # Отображаем поля
        self.product_name_entry.pack()
        self.product_price_entry.pack()
        self.product_quantity_entry.pack()
        self.product_supplier_id_entry.pack()
        self.product_category_entry.pack()
        self.product_description_entry.pack()

        # Кнопка для добавления товара
        tk.Button(self.root, text="Добавить товар", command=self.add_product).pack()

    # Функция для отображения товаров
    def show_products(self):
        conn = connect_db()
        cur = conn.cursor()
        cur.execute('SELECT product_name, price, stock_quantity FROM trade_organization.products;')
        rows = cur.fetchall()
        conn.close()

        # Отображение списка товаров
        result = "\n".join([f"{row[0]} — {row[1]} руб. — {row[2]} шт." for row in rows])
        messagebox.showinfo("Товары", result)

    # Функция для добавления товара
    def add_product(self):
        name = self.product_name_entry.get()
        price = float(self.product_price_entry.get())
        quantity = int(self.product_quantity_entry.get())
        supplier_id = int(self.product_supplier_id_entry.get())
        category = self.product_category_entry.get()
        description = self.product_description_entry.get()

        conn = connect_db()
        cur = conn.cursor()
        cur.execute("""
            INSERT INTO trade_organization.products (product_name, price, stock_quantity, supplier_id, category, description)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (name, price, quantity, supplier_id, category, description))
        conn.commit()
        conn.close()

        messagebox.showinfo("Успешно", "Товар добавлен")

    # Вкладка для работы с клиентами
    def create_clients_tab(self):
        self.clear_frame()
        tk.Label(self.root, text="Клиенты").pack()

        # Кнопка для возврата в главное меню
        tk.Button(self.root, text="Назад в меню", command=self.create_main_interface).pack()

        # Кнопка для отображения всех клиентов
        tk.Button(self.root, text="Показать клиентов", command=self.show_clients).pack()

        # Форма для добавления нового клиента
        tk.Label(self.root, text="Добавить нового клиента").pack()
        self.client_name_entry = tk.Entry(self.root)
        self.client_name_entry.insert(0, "ФИО клиента")
        self.client_phone_entry = tk.Entry(self.root)
        self.client_phone_entry.insert(0, "Телефон")

        self.client_name_entry.pack()
        self.client_phone_entry.pack()
        tk.Button(self.root, text="Добавить клиента", command=self.add_client).pack()

    # Функция для отображения клиентов
    def show_clients(self):
        conn = connect_db()
        cur = conn.cursor()
        cur.execute("SELECT full_name, phone FROM trade_organization.customers")
        rows = cur.fetchall()
        conn.close()

        result = "\n".join([f"{row[0]} — {row[1]}" for row in rows])
        messagebox.showinfo("Клиенты", result)

    # Функция для добавления клиента
    def add_client(self):
        name = self.client_name_entry.get()
        phone = self.client_phone_entry.get()

        conn = connect_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO trade_organization.customers (full_name, phone) VALUES (%s, %s)", (name, phone))
        conn.commit()
        conn.close()

        messagebox.showinfo("Успешно", "Клиент добавлен")

    # Вкладка для работы с продажами
    def create_sales_tab(self):
        self.clear_frame()
        tk.Label(self.root, text="Продажи").pack()

        # Кнопка для возврата в главное меню
        tk.Button(self.root, text="Назад в меню", command=self.create_main_interface).pack()

        # Форма для регистрации новой продажи
        tk.Label(self.root, text="Регистрация новой продажи").pack()
        self.sale_client_id_entry = tk.Entry(self.root)
        self.sale_client_id_entry.insert(0, "ID клиента")
        self.sale_total_entry = tk.Entry(self.root)
        self.sale_total_entry.insert(0, "Общая сумма")

        self.sale_client_id_entry.pack()
        self.sale_total_entry.pack()
        tk.Button(self.root, text="Зарегистрировать продажу", command=self.add_sale).pack()

    # Функция для добавления продажи
    def add_sale(self):
        client_id = int(self.sale_client_id_entry.get())
        total = float(self.sale_total_entry.get())

        conn = connect_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO trade_organization.sales (customer_id, total_amount) VALUES (%s, %s)", (client_id, total))
        conn.commit()
        conn.close()

        messagebox.showinfo("Успешно", "Продажа зарегистрирована")

    # Очистка фрейма для смены вкладок
    def clear_frame(self):
        for widget in self.root.winfo_children():
            widget.destroy()

# Запуск приложения
if __name__ == "__main__":
    root = tk.Tk()
    app = DatabaseApp(root)
    root.mainloop()
