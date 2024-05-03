class trilio::wlmapi::config inherits trilio::wlmapi {
    tag 'trilioobjectstoreconfig'



# Iterate over backup_targets parameter
    $backup_targets.each |$target| {
      # Check if backup_target_type = s3
      if $target['backup_target_type'] == 's3' {
        $conf_file_name = "/etc/triliovault-object-store/triliovault-object-store_${target['backup_target_name']}.conf"

        # Create conf file
        file { $conf_file_name:
          ensure  => present,
          content => epp('trilio/triliovault_object_store.conf.epp', {
            backup_target_name    => $target['backup_target_name'],
            s3_accesskey          => $target['s3_access_key'],
            s3_secretkey          => $target['s3_secret_key'],
            s3_bucket             => $target['s3_bucket'],
            s3_region_name        => $target['s3_region_name'],
            s3_auth_version       => $target['s3_auth_version'],
            s3_signature_version  => $target['s3_signature_version'],
            s3_ssl_enabled        => $target['s3_ssl_enabled'],
            s3_ssl_verify         => $target['s3_ssl_verify'],
            s3_type               => $target['s3_type'],
            s3_endpoint_url       => $target['s3_endpoint_url'],
            vault_data_dir        => $vault_data_dir,
          }),
        }
      }
    }



      file { '/etc/triliovault-object-store/':
          ensure => 'directory',
          owner  => '42436',
          group  => '42436',
      }->
      file { "/etc/triliovault-object-store/triliovault-object-store.conf":
          ensure  => present,
          content => template('trilio/triliovault_object_store_conf.erb'),
          owner  => '42436',
          group  => '42436',
          mode   => '0644',
      }
      file { "/etc/triliovault-object-store/object_store_logging.conf":
          ensure  => present,
          content => template('trilio/object_store_logging_conf.erb'),
          owner  => '42436',
          group  => '42436',
          mode   => '0644',
      }


}
