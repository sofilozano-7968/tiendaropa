-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: tienda_ropa
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Producto',7,'add_producto'),(26,'Can change Producto',7,'change_producto'),(27,'Can delete Producto',7,'delete_producto'),(28,'Can view Producto',7,'view_producto'),(29,'Can add Movimiento de inventario',8,'add_movimientoinventario'),(30,'Can change Movimiento de inventario',8,'change_movimientoinventario'),(31,'Can delete Movimiento de inventario',8,'delete_movimientoinventario'),(32,'Can view Movimiento de inventario',8,'view_movimientoinventario'),(33,'Can add Venta',9,'add_venta'),(34,'Can change Venta',9,'change_venta'),(35,'Can delete Venta',9,'delete_venta'),(36,'Can view Venta',9,'view_venta'),(37,'Can add Detalle de venta',10,'add_detalleventa'),(38,'Can change Detalle de venta',10,'change_detalleventa'),(39,'Can delete Detalle de venta',10,'delete_detalleventa'),(40,'Can view Detalle de venta',10,'view_detalleventa');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$GF54oADFryDtjqhMGS0i4v$aCfK+i1dwXDYtecA6Iy3hlgHDkylkiiOshnmeKS1VnU=','2026-07-23 17:32:35.707591',1,'sofi','','','sofilozano796@gmail.com',1,1,'2026-07-20 18:36:14.752056');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'inventario','movimientoinventario'),(7,'inventario','producto'),(6,'sessions','session'),(10,'ventas','detalleventa'),(9,'ventas','venta');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-07-20 18:35:39.130222'),(2,'auth','0001_initial','2026-07-20 18:35:39.913184'),(3,'admin','0001_initial','2026-07-20 18:35:40.069928'),(4,'admin','0002_logentry_remove_auto_add','2026-07-20 18:35:40.088654'),(5,'admin','0003_logentry_add_action_flag_choices','2026-07-20 18:35:40.102345'),(6,'contenttypes','0002_remove_content_type_name','2026-07-20 18:35:40.208287'),(7,'auth','0002_alter_permission_name_max_length','2026-07-20 18:35:40.363547'),(8,'auth','0003_alter_user_email_max_length','2026-07-20 18:35:40.436755'),(9,'auth','0004_alter_user_username_opts','2026-07-20 18:35:40.452645'),(10,'auth','0005_alter_user_last_login_null','2026-07-20 18:35:40.549664'),(11,'auth','0006_require_contenttypes_0002','2026-07-20 18:35:40.553544'),(12,'auth','0007_alter_validators_add_error_messages','2026-07-20 18:35:40.565854'),(13,'auth','0008_alter_user_username_max_length','2026-07-20 18:35:40.589029'),(14,'auth','0009_alter_user_last_name_max_length','2026-07-20 18:35:40.612744'),(15,'auth','0010_alter_group_name_max_length','2026-07-20 18:35:40.633430'),(16,'auth','0011_update_proxy_permissions','2026-07-20 18:35:40.649999'),(17,'auth','0012_alter_user_first_name_max_length','2026-07-20 18:35:40.670526'),(18,'inventario','0001_initial','2026-07-20 18:35:40.787595'),(19,'sessions','0001_initial','2026-07-20 18:35:40.831685'),(20,'ventas','0001_initial','2026-07-20 18:35:40.983403'),(21,'inventario','0002_alter_movimientoinventario_cantidad','2026-07-23 16:06:32.753188');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('b39dihb557txeqq6q185jiilg3966wb9','.eJxVjEsOwjAMBe-SNYqcOOmHJXvOUNmJTQqolZp2hbg7VOoCtm9m3ssMtK1l2Kosw5jN2Thz-t2Y0kOmHeQ7TbfZpnlal5HtrtiDVnudszwvh_t3UKiWbx19UiXPWVWwUQEVatpWGuxBGQi7ACFJxKAQe3XASCwI5LrgGZ15fwAVjzh5:1wmxHf:om_3friBhs5Nt5pXOsNhBQqxw1lngNNzIePxhGWJ9dY','2026-08-06 17:32:35.714557'),('id63dji4e2ouon159610aydb770uv9x7','.eJxVjEsOwjAMBe-SNYqcOOmHJXvOUNmJTQqolZp2hbg7VOoCtm9m3ssMtK1l2Kosw5jN2Thz-t2Y0kOmHeQ7TbfZpnlal5HtrtiDVnudszwvh_t3UKiWbx19UiXPWVWwUQEVatpWGuxBGQi7ACFJxKAQe3XASCwI5LrgGZ15fwAVjzh5:1wlsrL:I7J_teie2zuEfdyNueLLEbKoMlUvLCfqGH7RTYNG0HM','2026-08-03 18:36:59.753963');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_movimientoinventario`
--

DROP TABLE IF EXISTS `inventario_movimientoinventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_movimientoinventario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_movimiento` varchar(10) NOT NULL,
  `cantidad` int(10) unsigned NOT NULL CHECK (`cantidad` >= 0),
  `fecha` datetime(6) NOT NULL,
  `observacion` longtext NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventario_movimient_producto_id_cec1a696_fk_inventari` (`producto_id`),
  CONSTRAINT `inventario_movimient_producto_id_cec1a696_fk_inventari` FOREIGN KEY (`producto_id`) REFERENCES `inventario_producto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_movimientoinventario`
--

LOCK TABLES `inventario_movimientoinventario` WRITE;
/*!40000 ALTER TABLE `inventario_movimientoinventario` DISABLE KEYS */;
INSERT INTO `inventario_movimientoinventario` VALUES (1,'entrada',1000,'2026-07-20 18:39:11.376846','',1),(2,'salida',10,'2026-07-20 18:45:18.404393','Por Daños',2),(3,'salida',1000,'2026-07-20 18:46:54.477750','Por Daños',1),(4,'entrada',1000,'2026-07-20 18:47:40.926126','',1),(5,'salida',1000,'2026-07-20 18:48:01.232096','',1),(6,'salida',900,'2026-07-20 19:11:08.776266','',1),(7,'entrada',100,'2026-07-20 19:13:49.200120','',4),(8,'entrada',200,'2026-07-20 19:14:03.791219','',3),(9,'entrada',100,'2026-07-20 19:14:17.868868','',4),(10,'entrada',100,'2026-07-20 19:36:54.552201','',1),(11,'entrada',100,'2026-07-22 18:17:28.735022','LLegada de Jeans nuevos de mejor calidad',1),(12,'entrada',0,'2026-07-22 19:24:22.157376','',4),(13,'entrada',0,'2026-07-23 16:03:09.082830','',4),(14,'entrada',1,'2026-07-23 16:07:21.327793','',4);
/*!40000 ALTER TABLE `inventario_movimientoinventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_producto`
--

DROP TABLE IF EXISTS `inventario_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_producto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` longtext NOT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `stock` int(10) unsigned NOT NULL CHECK (`stock` >= 0),
  `estado` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_producto`
--

LOCK TABLES `inventario_producto` WRITE;
/*!40000 ALTER TABLE `inventario_producto` DISABLE KEYS */;
INSERT INTO `inventario_producto` VALUES (1,'Jean Azul','',120000.00,180000.00,209,'activo'),(2,'Crop top azul','',50000.00,60000.00,86,'activo'),(3,'Chaqueta de Cuero','',80000.00,120000.00,296,'activo'),(4,'Blusa Rosa','Se inactiva por el material',50000.00,80000.00,200,'inactivo');
/*!40000 ALTER TABLE `inventario_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_detalleventa`
--

DROP TABLE IF EXISTS `ventas_detalleventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_detalleventa` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cantidad` int(10) unsigned NOT NULL CHECK (`cantidad` >= 0),
  `precio` decimal(10,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  `venta_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ventas_detalleventa_producto_id_a820c807_fk_inventari` (`producto_id`),
  KEY `ventas_detalleventa_venta_id_c370bcd7_fk_ventas_venta_id` (`venta_id`),
  CONSTRAINT `ventas_detalleventa_producto_id_a820c807_fk_inventari` FOREIGN KEY (`producto_id`) REFERENCES `inventario_producto` (`id`),
  CONSTRAINT `ventas_detalleventa_venta_id_c370bcd7_fk_ventas_venta_id` FOREIGN KEY (`venta_id`) REFERENCES `ventas_venta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_detalleventa`
--

LOCK TABLES `ventas_detalleventa` WRITE;
/*!40000 ALTER TABLE `ventas_detalleventa` DISABLE KEYS */;
INSERT INTO `ventas_detalleventa` VALUES (1,1,120000.00,120000.00,3,1),(2,1,60000.00,60000.00,2,1),(3,1,180000.00,180000.00,1,2),(4,2,120000.00,240000.00,3,2),(5,2,60000.00,120000.00,2,2),(6,1,80000.00,80000.00,4,3),(7,1,60000.00,60000.00,2,3),(8,1,80000.00,80000.00,4,4),(9,90,180000.00,16200000.00,1,4),(10,1,80000.00,80000.00,4,5),(11,1,120000.00,120000.00,3,6);
/*!40000 ALTER TABLE `ventas_detalleventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_venta`
--

DROP TABLE IF EXISTS `ventas_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_venta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fecha` datetime(6) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_venta`
--

LOCK TABLES `ventas_venta` WRITE;
/*!40000 ALTER TABLE `ventas_venta` DISABLE KEYS */;
INSERT INTO `ventas_venta` VALUES (1,'2026-07-20 18:44:28.361013',180000.00),(2,'2026-07-20 19:02:09.233125',540000.00),(3,'2026-07-20 19:10:44.717980',140000.00),(4,'2026-07-20 19:36:39.028346',16280000.00),(5,'2026-07-22 19:14:47.632593',80000.00),(6,'2026-07-23 16:08:46.409620',120000.00);
/*!40000 ALTER TABLE `ventas_venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-24  1:30:17
