<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Onboarding CRM Flowchart</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        #flowchart {
            width: 100%;
            max-width: 1200px;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div id="flowchart">
        <div class="mermaid">
%%{init: {'theme': 'base', 'themeVariables': { 'primaryColor': '#ffcccc', 'edgeLabelBackground':'#ffffee', 'tertiaryColor': '#fff0f0'}}}%%
graph TD
    A[Start] --> B[Prospect]
    B --> C{Lead Type?}
    C -->|Online| D[CET Triggered]
    C -->|Offline| E[Orientation Triggered]
    
    %% Orientation Process
    E -->|Send orientation page link| F{Google Form Response?}
    F -->|Yes| D
    F -->|No| G[Orientation Pending]
    G -->|After 3 days| H{Response Received?}
    H -->|Yes| D
    H -->|No| I[CET Pending]
    
    %% CET Process
    D -->|Integration: Mettl| J[Send Mettl Link]
    J --> K{CET Attempted?}
    K -->|Yes| L{CET Pass?}
    K -->|No, Online: 15 days, Offline: 3 days| M[CET Pending]
    M -->|Trigger: Webengagee| N[Send reminder comms]
    N --> J
    
    L -->|Yes| O{Lead Type?}
    L -->|No| P[CET Fail]
    P -->|After 30 days| Q{Retake Count < 2?}
    Q -->|Yes| R[Retrigger CET]
    R --> D
    Q -->|No| S[Permanent Fail]
    
    O -->|Online| T[Interview Pending]
    O -->|Offline| U[Infra Triggered]
    
    %% Infrastructure Check
    U -->|Send comms for photos| V{Photos Received?}
    V -->|Yes| W[Infra Pass]
    V -->|No, after 3 days| X[Infra Pending]
    X -->|Trigger: Webengagee| Y[Send reminder comms]
    Y --> U
    W --> T
    
    %% Interview Process
    T -->|Trigger: Calendly| Z[Interview Scheduled]
    Z --> AA[Interview Done]
    AA --> AB{Interview Pass?}
    AB -->|Yes| AC{Lead Type?}
    AB -->|No| AD[Fail]
    
    AC -->|Offline| AE[Payment Triggered]
    AC -->|Online| AF[Training Offer Letter Sent]
    
    %% Payment Process
    AE -->|Integration: Payment Gateway| AG{Payment Received?}
    AG -->|Yes| AH[Payment Done]
    AG -->|No, after 1 day| AI[Payment Pending]
    AI -->|Trigger: Webengagee| AJ[Send reminder comms]
    AJ --> AE
    
    %% Agreement Process
    AH --> AK[Agreement Triggered]
    AK -->|Integration: DocuSign| AL{Agreement Signed?}
    AL -->|Yes| AM[Agreement Done]
    AL -->|No, after 1 day| AN[Agreement Pending]
    AN -->|Trigger: Webengagee| AO[Send reminder comms]
    AO --> AK
    
    AM --> AP[Training Triggered]
    
    %% Online-specific Process
    AF -->|Integration: Typeform| AQ{Acknowledgment?}
    AQ -->|Yes| AR[Induction Triggered]
    AQ -->|No, after 48 hours| AS[Dropped from Training]
    
    AR -->|Integration: Typeform| AT{Induction Confirmed?}
    AT -->|Yes| AP
    AT -->|No/Pending after 24 hrs| AU[Training Not Confirmed]
    
    %% Training Process
    AP -->|Integration: LMS| AV{Training Started?}
    AV -->|Yes| AW[Training In Progress]
    AV -->|No, after 24 hours| AX[Training Pending]
    AX -->|Trigger: Webengagee| AY[Send reminder comms]
    AY --> AP
    
    AW -->|Integration: LMS| AZ{Training Pass?}
    AZ -->|Yes| BA{Lead Type?}
    AZ -->|No| BB[Training Fail]
    
    BA -->|Online| BC[Launch]
    BA -->|Offline| BD[Finished Training]
    
    BC -->|Integration: CRM| BE[Create Teacher Profile]
    BD -->|Integration: CRM| BE
    
    BE --> BF[End]

    %% SLAs and Conditions
    classDef sla fill:#f9f,stroke:#333,stroke-width:2px;
    class M,X,AI,AN,AS sla;
    
    %% Integrations
    classDef integration fill:#bbf,stroke:#333,stroke-width:2px;
    class J,AG,AL,AQ,AT,AV,AZ,BE integration;
    
    %% Trigger Points
    classDef trigger fill:#bfb,stroke:#333,stroke-width:2px;
    class N,Y,AJ,AO,AY trigger;
        </div>
    </div>
    <script>
        mermaid.initialize({ startOnLoad: true });
    </script>
</body>
</html>