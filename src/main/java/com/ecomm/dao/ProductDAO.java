package com.ecomm.dao;

import com.ecomm.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProductDAO {
    private static final Logger logger = LoggerFactory.getLogger(ProductDAO.class);
    private final javax.sql.DataSource ds = DBPool.getDataSource();

    // Get all active products
    public List<Product> getAll() {
        return findAll(null);
    }

    // Get active products by seller
    public List<Product> findBySeller(int sellerId) {
        return findAll("seller_id = " + sellerId);
    }

    // Core method to fetch products
    private List<Product> findAll(String whereClause) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_active = TRUE"
                + (whereClause != null ? " AND " + whereClause : "")
                + " ORDER BY created_at DESC";

        try (Connection c = ds.getConnection(); Statement s = c.createStatement(); ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Find by product ID
    public Product findById(int id) {
        String sql = "SELECT * FROM products WHERE id=? AND is_active = TRUE";
        try (Connection c = ds.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // Map ResultSet row to Product
    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setSellerId(rs.getInt("seller_id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setImage(rs.getString("image"));
        p.setPrice(rs.getDouble("price"));
        p.setStock(rs.getInt("stock"));
        return p;
    }


    // Save new product
    public int save(Product p) {
        logger.info("Saving new product: {}", p.getName());
        String sql = "INSERT INTO products(seller_id, name, description, image, price, stock) VALUES(?, ?, ?, ?, ?, ?)";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, p.getSellerId());
            ps.setString(2, p.getName());
            ps.setString(3, p.getDescription());
            ps.setString(4, p.getImage());
            ps.setDouble(5, p.getPrice());
            ps.setInt(6, p.getStock());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int productId = rs.getInt(1);
                    logger.info("Product saved successfully with ID: {}", productId);
                    return productId;
                }
            }

        } catch (SQLException e) {
            logger.error("Failed to save product: {}. Error: {}", p.getName(), e.getMessage(), e);
        }

        return -1;
    }


    // Update product
    public boolean update(Product p) {
        String sql = "UPDATE products SET name=?, description=?, image=?, price=?, stock=? WHERE id=? AND is_active = TRUE";

        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setString(3, p.getImage()); // fixing missing image update
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getStock());
            ps.setInt(6, p.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    // Soft delete product
    public boolean softDelete(int id) {
        String sql = "UPDATE products SET is_active = FALSE WHERE id = ?";
        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public List<Product> search(String keyword) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE name LIKE ? AND is_active = TRUE ";

        try (Connection con = ds.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, "%" + keyword + "%");
            //pst.setString(2, "%" + keyword + "%");

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
               // p.setCategory(rs.getString("category"));
                p.setStock(rs.getInt("stock"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image")); // <-- If you store image path
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public byte[] getImageById(int id) {
        String sql = "SELECT image FROM products WHERE id=?";
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBytes("image");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }






    public int countProducts() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = TRUE";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }




}