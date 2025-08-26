package hrc.entity;

public class OrderPromo {
    private Long orderId;
    private Long promoId;
    
    public OrderPromo() {}
    
    public OrderPromo(Long orderId, Long promoId) {
        this.orderId = orderId;
        this.promoId = promoId;
    }
    
    public Long getOrderId() {
        return orderId;
    }
    
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }
    
    public Long getPromoId() {
        return promoId;
    }
    
    public void setPromoId(Long promoId) {
        this.promoId = promoId;
    }
}
