---  
tags: [knowledge, ccna, chapter-12]  
created: 2026-04-30  
cert: CCNA  
chapter: 12  
source: rewritten  
---  

# 12. Dynamic & VLAN Trunking Protocol  
**[One-sentence bold subtitle describing what this note covers]**  
> *“Unleash the power of dynamic link negotiation and automated VLAN management across Cisco switches.”*  

---  

## Dynamic Trunking Protocol (DTP)  

### Purpose  

**Analogy**: Picture two chefs in a kitchen who can instantly decide whether to share a single pan (trunk) or keep their own pans (access) without a menu—DTP lets switches make that call on the fly.  

**Dynamic Trunking Protocol (DTP)**: A Cisco‑only mechanism that enables adjacent switches to automatically determine if a port should act as an *access* or *trunk* link, using DTP frames to negotiate the role.  

---  

### Administrative vs Operational Mode  

**Analogy**: Think of a car’s cruise control: you set the target speed (administrative), but the actual speed (operational) may differ if the road changes.  

**Administrative mode**: The mode you configure with `switchport mode` (e.g., access, trunk, dynamic‑auto, dynamic‑desirable).  

**Operational mode**: The mode the port actually uses after DTP negotiation.  

| Admin | Oper | Result |  
|-------|------|--------|  
| `access` | `access` | Fixed access port – no DTP traffic |  
| `trunk` | `trunk` | Fixed trunk port – DTP frames exchanged |  
| `dynamic‑auto` | varies | Trunk if neighbor requests, else access |  
| `dynamic‑desirable` | varies | Trunk if neighbor supports, else access |  

---  

### DTP Administrative Modes  

**Analogy**: Imagine a gate that can be locked, unlocked, or set to open automatically when the right key arrives.  

| Mode | Description | DTP Behavior |  
|------|-------------|--------------|  
| `access` | Manually forces an access port | No DTP frames sent |  
| `trunk` | Manually forces a trunk port | DTP frames sent to confirm agreement |  
| `dynamic‑auto` | Default on many switches | Passively listens for trunk requests |  
| `dynamic‑desirable` | Actively seeks trunking | Initiates trunk negotiation with neighbors |  

```  
switchport mode access  
switchport mode trunk  
switchport mode dynamic‑auto  
switchport mode dynamic‑desirable  
```  

---  

### DTP Negotiation Results (Operational Mode)  

**Analogy**: Two people deciding whether to ride a tandem bike (trunk) or each ride solo (access). The outcome depends on both parties’ preferences.  

| Neighbor 1 | Neighbor 2 | Port Result |  
|------------|------------|-------------|  
| access | access | access |  
| access | dynamic‑auto | access |  
| access | dynamic‑desirable | access |  
| trunk | trunk | trunk |  
| trunk | dynamic‑auto | trunk |  
| trunk | dynamic‑desirable | trunk |  
| dynamic‑desirable | dynamic‑desirable | trunk |  
| dynamic‑auto | dynamic‑auto | access |  
| access | trunk | **invalid** (misconfiguration) |  

---  

### Viewing DTP Status  

**Analogy**: Like looking at a traffic light’s status—red (access) or green (trunk)—to see how the link is behaving.  

```  
show interfaces GigabitEthernet0/1 switchport  
```  

The output displays:  
- *Administrative mode*  
- *Operational mode*  
- Whether *trunk negotiation* (DTP) is enabled.  

---  

### Trunk Encapsulation Negotiation  

**Analogy**: Two friends picking a common language for texting; if both can use an emoji‑rich language (ISL) they’ll default to that, but it’s safer to agree on plain text (802.1Q).  

- Switches that support both ISL and 802.1Q default to *negotiate*.  
- If both ends negotiate, ISL is chosen.  
- Best practice: **Manually configure 802.1Q** to avoid surprises.  

```  
switchport trunk encapsulation dot1q  
```  

Modern switches often support only 802.1Q, making manual configuration the norm.  

---  

### Disabling DTP (Best Practice)  

**Analogy**: Turning off a wireless microphone so only the intended speaker can talk—reduces the chance of eavesdroppers hijacking the channel.  

**Why disable?**  
- DTP can be spoofed, allowing attackers to push a switch into trunk mode and access all VLANs.  

**How to disable**  

| Method | Command | Effect |  
|--------|---------|--------|  
| Set to access | `switchport mode access` | No DTP frames, fixed access port |  
| Explicitly turn off negotiation | `switchport nonegotiate` | DTP disabled even if mode changes later |  

```  
interface GigabitEthernet0/1  
 switchport mode access  
 switchport nonegotiate  
```  

---  

## VLAN Trunking Protocol (VTP)  

### Purpose  

**Analogy**: Like a library’s catalog system that keeps every branch’s book list in sync, VTP ensures all switches in a network share the same VLAN database.  

**VLAN Trunking Protocol (VTP)**: A Cisco‑only protocol that propagates VLAN information across switches, preventing mismatches on trunk links.  

---  

### VLAN Database  

**Analogy**: The master index card that lists every book’s title and location.  

- Stored in `vlan.dat` on each switch.  
- View with:  

```  
show vlan brief  
```  

---  

### VTP Domains  

**Analogy**: Book clubs that only exchange catalogs within the same club.  

- A *VTP domain* groups switches that share the same domain name.  
- Switches only sync VLANs within the same domain.  
- Default state: *NULL* domain → no VTP messages exchanged.  

```  
vtp domain MyDomain  
```  

---  

### VTP Revision Number  

**Analogy**: A version number on a shared document; newer edits overwrite older ones.  

- Starts at **0**.  
- Incremented with each VLAN change.  
- Switches accept updates only from peers with a higher revision number; equal or lower revisions are ignored.  

---  

### Viewing VTP Status  

**Analogy**: Checking the status of a group chat—who’s in it, how it’s configured, and what version it’s on.  

```  
show vtp status  
```  

Displays:  
- VTP domain name  
- Mode (server, client, transparent, off)  
- Version (1, 2, 3)  
- Revision number  
- Number of VLANs in the database  

---  

### VTP Modes  

| Mode | Key Features | Ability to Modify VLANs | VTP Message Flow | Revision Behavior |  
|------|--------------|------------------------|------------------|-------------------|  
| **server** *(default)* | Can create, modify, delete VLANs | Yes | Forwards to clients | Syncs to higher revisions |  
| **client** | Read‑only VLANs | No | Receives from servers | Syncs to higher revisions |  
| **transparent** | Local changes allowed | Yes | Forwards VTP messages but does not advertise | Revision always **0** |  
| **off** | VTP disabled entirely | Yes | No VTP traffic | VTP inactive |  

```  
vtp mode server  
vtp mode client  
vtp mode transparent  
vtp mode off  
```  

---  

### VTP Versions  

| Version | Range of VLANs | Token Ring Support | Off Mode | Primary Server |  
|---------|----------------|---------------------|----------|----------------|  
| **1** | 1–1005 | No | No | No |  
| **2** | 1–1005 | Yes (rarely used) | No | No |  
| **3** | 1–4094 | No | Yes | Yes (only primary server can alter VLANs) |  

```  
vtp version 3  
vtp primary  
```  

Only one switch in a domain can be set as the *primary server*; it’s the sole authority for VLAN creation or deletion.  

---  

## Exam Tips  

### Question Type 1: Multiple Choice  
- *“A switch is configured with `switchport mode dynamic‑desirable`. What is the likely operational mode after negotiation with an access port?”* → **Access**  
- **Trick**: Don’t assume *dynamic‑desirable* always produces a trunk; the neighbor’s mode matters.  

### Question Type 2: Configuration  
- *“Which command disables DTP negotiation on an access port?”* → `switchport nonegotiate`  
- **Trick**: Mixing up `switchport mode access` (which still enables DTP) with `nonegotiate`.  

---  

## Common Mistakes  

### Mistake 1: Assuming `switchport mode access` disables DTP  
- **Wrong**: `switchport mode access` keeps DTP frames on the wire if the port is set to *dynamic‑auto* or *dynamic‑desirable*.  
- **Right**: Use `switchport nonegotiate` in addition to setting the port to access to fully shut off DTP.  
- **Impact on Exam**: A question may test whether you know that disabling DTP requires the *nonegotiate* command; missing it can lead to a wrong answer.  

---  

## Related Topics  
- [[VLAN]]  
- [[Trunking]]  
- [[Port Security]]  
- [[Spanning Tree Protocol (STP)]]  

---  

*Source: CCNA 200-301 Study Notes | [[CCNA]]*