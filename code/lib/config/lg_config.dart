class LGConfig {
  // This constant list that holds the IP adresses as strings
  // The list size should match the LG size, so in this case it should be 5 IPs (one per screen)
  // The number of screens does not always have to be 5, 3 for example is also valid
  static const List<String> lgIps = [
    // Through 'ipconfig' you can get these IPs (check this)
    'IP1',   // Master node (screen 1)
    'IP2',   // Screen 2
    'IP3',   // Screen 3
    'IP4',   // Screen 4
    'IP5',   // Screen 5
  ]; 
  static const int sshPort = 22;             // This is the port number used for SSH (example, to be updated)
  static const String sshUser = 'lg';        // This is the username that will be used when connecting to the Liquid Galaxy via SSH
  static const String sshPassword = 'lg';    // This will be the password
  static const String kmlPath = '/var/www/html/kmls/';   // This defines the file path (on the remote computer) where KML files are stored
  static const String masterIp = lgIps.first;      // lgIps.first gets the first item in the list of IPs that was defined earlier
                                                   // It sets this first IP as masterIp, as typically the first IP is the master node
                                                   // The important thing is that you get here the IP of the master node
}
