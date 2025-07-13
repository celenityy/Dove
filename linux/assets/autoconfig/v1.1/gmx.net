<clientConfig version="1.1">
  <emailProvider id="gmx.net">
    <domain>gmx.net</domain>
    <domain>gmx.de</domain>
    <domain>gmx.at</domain>
    <domain>gmx.ch</domain>
    <domain>gmx.eu</domain>
    <domain>gmx.biz</domain>
    <domain>gmx.org</domain>
    <domain>gmx.info</domain>
    <domain>mein.gmx</domain>
    <domain>mail.gmx</domain>
    <domain>email.gmx</domain>
    <!-- see also other domains below -->
    <!-- gmx.com is same company, but different access servers -->
    <displayName>GMX Freemail</displayName>
    <displayShortName>GMX</displayShortName>
    <!-- imap officially costs money, but actually works with freemail accounts, too -->
    <incomingServer type="imap">
      <hostname>imap.gmx.net</hostname>
      <port>993</port>
      <socketType>SSL</socketType>
      <!-- Kundennummer (customer no) and email address should both work -->
      <username>%EMAILADDRESS%</username>
      <authentication>password-cleartext</authentication>
    </incomingServer>
    <incomingServer type="imap">
      <hostname>imap.gmx.net</hostname>
      <port>143</port>
      <socketType>STARTTLS</socketType>
      <username>%EMAILADDRESS%</username>
      <authentication>password-cleartext</authentication>
    </incomingServer>
    <incomingServer type="pop3">
      <hostname>pop.gmx.net</hostname>
      <port>995</port>
      <socketType>SSL</socketType>
      <!-- see above -->
      <username>%EMAILADDRESS%</username>
      <authentication>password-cleartext</authentication>
    </incomingServer>
    <incomingServer type="pop3">
      <hostname>pop.gmx.net</hostname>
      <port>110</port>
      <socketType>STARTTLS</socketType>
      <username>%EMAILADDRESS%</username>
      <authentication>password-cleartext</authentication>
    </incomingServer>
    <outgoingServer type="smtp">
      <hostname>mail.gmx.net</hostname>
      <port>465</port>
      <socketType>SSL</socketType>
      <!-- see above -->
      <username>%EMAILADDRESS%</username>
      <authentication>password-cleartext</authentication>
    </outgoingServer>
    <outgoingServer type="smtp">
      <hostname>mail.gmx.net</hostname>
      <port>587</port>
      <socketType>STARTTLS</socketType>
      <username>%EMAILADDRESS%</username>
      <authentication>password-cleartext</authentication>
    </outgoingServer>
    <documentation url="https://hilfe.gmx.net/pop-imap/imap/imap-serverdaten.html"/>
    <enable visiturl="https://hilfe.gmx.net/pop-imap/einschalten.html">
      <instruction>You must allow access via POP3 &amp; IMAP once in the e-mail settings of your account!</instruction>
      <instruction lang="de">Sie müssen einmalig den Zugriff über POP3 &amp; IMAP in den E-Mail-Einstellungen Ihres Kontos erlauben!</instruction>
    </enable>
  </emailProvider>
</clientConfig>
